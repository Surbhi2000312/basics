import 'dart:convert';
import 'dart:io';
import 'package:basics/model/EmployeeData.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DioScreen extends StatefulWidget {
  const DioScreen({super.key});

  @override
  State<DioScreen> createState() => _DioScreenState();
}

class _DioScreenState extends State<DioScreen> {
  final dio = Dio();
  List<EmployeeData> employeeList = [];
  bool isLoading = true;
  String errorMessage = '';

  // Custom POST method
  Future post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    // Add any authorization headers if required
    // Map<String, dynamic>? authorization = getAuthorizationHeader();
    // if (authorization != null) {
    //   requestOptions.headers!.addAll(authorization);
    // }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future<void> getPostApi() async {
    try {
      print("--------------------------------1111");
      final response = await dio.get("http://192.168.1.7:8080/users/");
      print("respons code ${response.statusCode}");
      print("--------------------------------222");

      if (response.statusCode == 200) {
        var data = response.data; // Use response.data instead of response.toString()
        employeeList.clear();
        for (Map i in data) {
          employeeList.add(EmployeeData.fromJson(i));
        }
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("--------------------------------2.5");
      if (e is SocketException && e.osError?.errorCode == 111) {
        // Handle errno 111 error
        print("Error: Connection refused (errno = 111)");
      } else if (e is DioException) {
        // Handle DioException
        // print("Error: DioException - ${e.message}");
        if (e.type == DioErrorType.connectionError) {
          print("--------------------------------values");
          // print("Error: Connection error - ${e.message}");
          print("Error: ");
          print("Server might be turn off");
          setState(() {
            isLoading = false;
            errorMessage = "Connection error";
          });
        }

        else if( e.response!.statusCode== 404){
          print("-------------------------------999999");
          print("failure, not found");
          print("Client error - the request contains bad syntax or cannot be fulfilled");

        print("--------------------------------999999");}
        setState(() {
          isLoading = false;
          errorMessage ="the request contains bad syntax";
        });


      } else {
        // Handle other exceptions
        print("Error: ${e.toString()}");
      }
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
        print("--------------------------------3333");
        // print("Error: $errorMessage");

        print("--------------------------------444");
      });
    }
  }

  void _openBottomSheet({Map<String, dynamic>? entry}) {
    TextEditingController idController = TextEditingController(text: entry?['id'] ?? '');
    TextEditingController nameController = TextEditingController(text: entry?['name'] ?? '');
    TextEditingController phoneController = TextEditingController(text: entry?['phone'] ?? '');
    TextEditingController emailController = TextEditingController(text: entry?['email'] ?? '');

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: 'ID'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Mobile No'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              final newEmployee = {
                'id': idController.text,
                'name': nameController.text,
                'phone': phoneController.text,
                'email': emailController.text,
              };

              try {
                if (entry == null) {
                  // If entry is null, it's a new record (POST)
                  await post("http://192.168.1.13:8080/users/", data: newEmployee);
                } else {
                  // Otherwise, update the existing record (PUT)
                  await put("http://192.168.1.13:8080/users/${entry['id']}", data: newEmployee);
                }
                Get.back(); // Close the bottom sheet
                getPostApi(); // Refresh the employee list
              } catch (e) {
                print('Failed to save employee: $e');
              }
            },
            child: Text("Save"),
          ),

          ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getPostApi();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text("Services are not available"))
                : employeeList.isEmpty
                ? Center(child: Text('No data available'))
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                final employee = employeeList[index];
                return ListTile(
                  leading: Text(employee.id!),
                  title: getTxtBlackColor(msg: employee.name ?? 'No name', fontSize: 18),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(employee.email ?? 'No Email'),
                      Text(employee.phone ?? 'No Phone'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Open bottom sheet for editing
                          _openBottomSheet(entry: {
                            'id': employee.id,
                            'name': employee.name,
                            'phone': employee.phone,
                            'email': employee.email,
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          try {
                            await delete("http://192.168.1.13:8080/users/${employee.id}");
                            getPostApi(); // Refresh the employee list
                          } catch (e) {
                            print('Failed to delete employee: $e');
                          }
                        },
                      ),
                    ],
                  ),
                );

              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBottomSheet(),
        child: Icon(Icons.add),
      ),
    );
  }
  // Custom PUT method
  Future put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  // Custom DELETE method
  Future delete(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    var response = await dio.delete(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }
 
}
