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

  void addFault(Fault fault) async {
    final response = await http.post(Uri.parse('http://10.0.2.2:8000/apis/v1/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(fault));
    if (response.statusCode == 201) {
      fault.id = json.decode(response.body)['id'];
      _faults.add(fault);
      notifyListeners();
    }
  }

  void deleteFault(Fault fault) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:8000/apis/v1/${fault.id}/'));
    if (response.statusCode == 204) {
      _faults.remove(fault);
      notifyListeners();
    }
  }

  fetchTask() async {
    final url = 'http://10.0.2.2:8000/apis/v1/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _faults = data.map<Fault>((json) => Fault.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
