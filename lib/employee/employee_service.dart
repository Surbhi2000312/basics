import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployeeService {
  final String baseUrl = 'http://192.168.1.12:8080';

  Future<List<dynamic>> getEmployees() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load employees');
    }
  }


  Future<dynamic> addEmployee(Map<String, String> employeeData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/employeeDetails'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(employeeData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add employee');
    }
  }

  Future<void> updateEmployee(int id, Map<String, String> employeeData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/employeeDetails/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(employeeData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update employee');
    }
  }

  Future<void> deleteEmployee(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/employeeDetails/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee');
    }
  }
}
