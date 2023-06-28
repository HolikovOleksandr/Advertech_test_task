// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class SendDataController {
  fetchData({
    required String name,
    required String email,
    required String message,
  }) async {
    String url = 'https://api.byteplex.info/api/test/contact/';

    Map<String, String> data = {
      'name': name,
      'email': email,
      'message': message,
    };

    String jsonData = json.encode(data);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Successful! ===${response.statusCode}===');
        return true;
      } else {
        print('Not successful ===${response.statusCode}===');
        return false;
      }
    } catch (e) {
      print('Error sending data: $e');
      return false;
    }
  }
}
