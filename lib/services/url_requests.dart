import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UrlRequests {
  static Future<dynamic> getRequest({required String url}) async {
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      return jsonDecode(response.body);
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return null;
    }
  }
}
