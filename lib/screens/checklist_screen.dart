import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  static const routeName = 'check';
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist item with id: $id'),
      ),
    );
  }
}
