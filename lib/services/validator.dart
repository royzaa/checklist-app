import 'package:flutter/cupertino.dart';

class EmailValidator {
  static String? validate(String? email) {
    if (email == '' || email!.isEmpty) {
      return 'Email tidak boleh kosong';
    } else {
      return null;
    }
  }
}

class UsernameValidator {
  static String? validate(String? nik) {
    RegExp regExp = RegExp(r'^[1-9]+[0-9]*$');
    if (nik == '' || nik!.isEmpty) {
      return 'Username tidak boleh kosong';
    } else {
      return null;
    }
  }
}

class PasswordValidator {
  static String? validate(String? password) {
    RegExp regExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])');
    if (password == '' || password!.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (!regExp.hasMatch(password)) {
      return 'Password harus memiliki huruf besar, kecil, dan angka';
    } else if (password.length < 8) {
      return 'Password minimal berjumlah 8 digit';
    } else {
      return null;
    }
  }
}
