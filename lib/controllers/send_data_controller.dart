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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
