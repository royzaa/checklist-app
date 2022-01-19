import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import './data_preferences.dart';
import '../model/checklist.dart';

class Api {
  static const baseurl = 'http://94.74.86.174:8080/api/';

  static Future<bool> register(
      {required String username,
      required String email,
      required String password}) async {
    bool status = false;
    final url = Uri.parse('$baseurl/register');
    final response = await http.post(url,
        body: {"email": email, "password": password, "username": username});

    if (response.statusCode == 200 || response.statusCode == 2000) {
      final url = Uri.parse('$baseurl/login');
      final response = await http
          .post(url, body: {"password": password, "username": username});

      if (response.statusCode == 200 || response.statusCode == 2000) {
        final jsonBody = jsonDecode(response.body);
        final data = jsonBody['data'];
        debugPrint(data['token'].toString());
        DataPreferences.setToken(data['token']).then((value) => status = true);
        DataPreferences.setUserName(username);
      }
    }
    return status;
  }

  static Future<String> login(
      {required String username, required String password}) async {
    String token = '';
    final url = Uri.parse('$baseurl/login');
    final response = await http
        .post(url, body: {"password": password, "username": username});

    if (response.statusCode == 200 || response.statusCode == 2000) {
      final jsonBody = jsonDecode(response.body);
      final data = jsonBody['data'];
      token = data['token'] as String;

      DataPreferences.setToken(token);
      DataPreferences.setUserName(username);
    }
    return token;
  }

  static Future<List<Checklist>> getAllCheckList() async {
    var listOfChecklist = <Checklist>[];
    if (DataPreferences.getToken().isNotEmpty) {
      final String token = DataPreferences.getToken();
      final url = Uri.parse('$baseurl/checklist');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200 || response.statusCode == 2001) {
        final jsonBody = jsonDecode(response.body);
        final data = jsonBody['data'];

        listOfChecklist = Checklist.getAllCheckList(data);
      }
    }
    return listOfChecklist;
  }

  static Future<bool> createCheckList(String title) async {
    bool status = false;

    final String token = DataPreferences.getToken();
    final url = Uri.parse('$baseurl/checklist');
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "name": title
    });

    if (response.statusCode == 200 || response.statusCode == 2001) {
      status = true;
    }

    return status;
  }

  static Future<bool> deleteCheckList(int id) async {
    bool status = false;

    final String token = DataPreferences.getToken();
    final url = Uri.parse('$baseurl/checklist/$id');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 2001) {
      status = true;
    }

    return status;
  }
}
