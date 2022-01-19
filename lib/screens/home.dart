import 'package:checklist/model/checklist.dart';
import 'package:checklist/screens/checklist_screen.dart';
import 'package:checklist/services/api.dart';
import 'package:checklist/widgets/refresh_checklist.dart';
import 'package:flutter/material.dart';

import '../services/data_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final name = DataPreferences.getUserName();
  final _titleController = TextEditingController();
  var listOfChecklist = <Checklist>[];

  @override
  void initState() {
    Api.getAllCheckList().then((value) {
      setState(() {
        listOfChecklist = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do list $name'),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Column(
                          children: [
                            TextField(
                              controller: _titleController,
                            ),
                            TextButton(
                              onPressed: () =>
                                  Api.createCheckList(_titleController.text),
                              child: const Text('Create'),
                            ),
                          ],
                        ),
                      )),
              icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshChecklist(
        onRefresh: () => Api.getAllCheckList().then((value) {
          setState(() {
            listOfChecklist = value;
          });
        }),
        child: FutureBuilder(
            future: Api.getAllCheckList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as List<Checklist>;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ChecklistScreen.routeName,
                          arguments: data[index].id,
                        ),
                        title: Text(data[index].name),
                        trailing: IconButton(
                            onPressed: () async => Api.deleteCheckList(
                                  int.parse(data[index].id),
                                ),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      );
                    });
              } else {
                return const LinearProgressIndicator();
              }
            }),
      ),
    );
  }
}
