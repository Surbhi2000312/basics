import 'dart:convert';
import 'package:basics/model/EmployeeData.dart';
import 'package:http/http.dart' as http;

class ApiBaseService {
  final String baseUrl = 'http://192.168.1.13:8080';
  List<EmployeeData> postList = [];

  Future<List<EmployeeData>> getEmployees() async {
    final response = await http.get(Uri.parse('$baseUrl/users/'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(EmployeeData.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }


  Future<void> addEmployee(Map<String, String> employeeData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(employeeData),
    );
    if (response.statusCode == 201) { // 201 Created
      // Employee added successfully
    } else {
      throw Exception('Failed to add employee');
    }
  }
  // Get employee by ID
  Future<EmployeeData?> getById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return EmployeeData.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Get employees by Name
  Future<List<EmployeeData>> getByName(String name) async {
    final allEmployees = await getEmployees();
    return allEmployees
        .where((employee) => employee.name!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  // Get employees by Phone
  Future<List<EmployeeData>> getByPhone(String phone) async {
    final allEmployees = await getEmployees();
    return allEmployees
        .where((employee) => employee.phone!.contains(phone))
        .toList();
  }

  // Get employees by Email
  Future<List<EmployeeData>> getByEmail(String email) async {
    final allEmployees = await getEmployees();
    return allEmployees
        .where((employee) => employee.email!.toLowerCase().contains(email.toLowerCase()))
        .toList();
  }

  Future<List<EmployeeData>> getByAll(String query) async {
    // Get all employees
    final allEmployees = await getEmployees();

    // Filter employees based on the query
    return allEmployees.where((employee) {
      final queryLower = query.toLowerCase();

      // Check if the query is a valid integer
      if (int.tryParse(query) != null) {
        return employee.id == int.parse(query);
      } else {
        return employee.name!.toLowerCase().contains(queryLower) ||
            employee.email!.toLowerCase().contains(queryLower) ||
            employee.phone!.contains(query);
      }
    }).toList();
  }



}
