import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/fault.dart';
import 'package:http/http.dart' as http;

class FaultProvider with ChangeNotifier {
  FaultProvider() {
    this.fetchTask();
  }
  List<Fault> _faults = [];

  List<Fault> get faults {
    return [..._faults];
  }

  fetchTask() async {
    final url = 'http://10.0.2.2:8000/apis/v1/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _faults = data.map<Fault>((json) => Fault.fromJson(json)).toList();
    }
  }
}
