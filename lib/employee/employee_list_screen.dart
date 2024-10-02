
import 'package:basics/employee/api_service.dart';
import 'package:basics/model/EmployeeData.dart';
import 'package:flutter/material.dart';
import 'employee_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<EmployeeData> postList = [];

  Future<List<EmployeeData>> getPostApi() async {
    // final response = await http.get(Uri.parse('http://192.168.1.12:8080/users/'));
    final response = await http.get(Uri.parse('http://192.168.1.13:8080/users/'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      postList.clear();
      for (Map i in data) {
        postList.add(EmployeeData.fromJson(i));
      }
      return postList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || postList.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID: ${postList[index].id}'),
                              Text('Name: ${postList[index].name}'),
                              Text('Phone: ${postList[index].phone}'),
                              Text('Email: ${postList[index].email}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

