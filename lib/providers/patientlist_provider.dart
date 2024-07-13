import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Patient {
  final String name;
  final String appointmentDate;

  Patient({required this.name, required this.appointmentDate});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      appointmentDate: json['appointment_date'],
    );
  }
}

class PatientListProvider with ChangeNotifier {
  List<Patient> _patients = [];
  bool _isLoading = false;

  List<Patient> get patients => _patients;
  bool get isLoading => _isLoading;

  Future<void> fetchPatientList() async {
    final url = Uri.parse('https://flutter-amr.noviindus.in/api/patients');

    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer YOUR_TOKEN_HERE', // Replace with your token
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _patients = responseData.map((json) => Patient.fromJson(json)).toList();
      } else {
        _patients = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _patients = [];
      _isLoading = false;
      notifyListeners();
    }
  }
}
