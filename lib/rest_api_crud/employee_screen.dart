import 'package:basics/model/EmployeeData.dart';
import 'package:basics/rest_api_crud/api_base_service.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final ApiBaseService _apiBaseService = ApiBaseService();
  List<EmployeeData> _employees = [];
  List<EmployeeData> _filteredEmployees = [];
  String _searchText = '';
  String _searchType = 'name'; // Default search type

  void _fetchEmployees() async {
    try {
      List<EmployeeData> employees = await _apiBaseService.getEmployees();
      setState(() {
        _employees = employees;
        _filteredEmployees = employees; // Initially, display all employees
      });
    } catch (e) {
      print(e);
    }
  }

  void _searchEmployees(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        _filteredEmployees = _employees; // Reset to full list when search is cleared
      });
      return;
    }

    final searchTerms = searchText.toLowerCase(); // Convert search text to lowercase
    final List<EmployeeData> searchResults = _employees.where((employee) {
      final employeeName = employee.name?.toLowerCase() ?? '';
      final employeeEmail = employee.email?.toLowerCase() ?? '';
      final employeePhone = employee.phone?.toLowerCase() ?? '';

      // Check if any part of the search terms exist in any of the employee's attributes
      return employeeName.contains(searchTerms) ||
          employeeEmail.contains(searchTerms) ||
          employeePhone.contains(searchTerms) ||
          employeeName.startsWith(searchTerms) ||
          employeeEmail.startsWith(searchTerms) ||
          employeePhone.startsWith(searchTerms);
    }).toList();

    setState(() {
      _filteredEmployees = searchResults;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getTxtBlackColor(msg: "Employee Screen"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      _searchText = value;
                      _searchEmployees(value); // Call _searchEmployees on every text change
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by $_searchType',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: null, // Remove the onPressed callback
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEmployees.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredEmployees[index].name.toString()),
                  subtitle: Text(_filteredEmployees[index].email.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
