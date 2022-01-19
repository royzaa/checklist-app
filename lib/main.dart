import 'package:checklist/screens/checklist_screen.dart';
import 'package:flutter/material.dart';

import './screens/login_screen.dart';
import './services/data_preferences.dart';
import './screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(108, 99, 255, 1),
      ),
      home: DataPreferences.getToken().isEmpty
          ? const LoginScreen()
          : const Home(),
      routes: {
        Home.routeName: (context) => const Home(),
        ChecklistScreen.routeName: (context) => const ChecklistScreen(),
      },
    );
  }
}
