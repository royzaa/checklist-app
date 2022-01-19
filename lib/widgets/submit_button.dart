import 'package:flutter/material.dart';

import '../services/data_preferences.dart';
import '../screens/home.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    Key? key,
    required this.future,
    required this.isForRegister,
    this.email,
    this.password,
    this.username,
  }) : super(key: key);
  final VoidCallback future;
  final String? email, password, username;
  final bool isForRegister;

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(widget.isForRegister ? 'Register' : 'Login'),
      onPressed: () {
        widget.future;
        if (DataPreferences.getToken().isNotEmpty) {
          Navigator.pushReplacementNamed(context, Home.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("gagal"),
            duration: Duration(milliseconds: 300),
          ));
        }
      },
    );
  }
}
