import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  List<Map<String, dynamic>> formList = [];
  int nextId = 1;

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  void _loadFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formData = prefs.getString('formList');
    if (formData != null) {
      setState(() {
        formList = List<Map<String, dynamic>>.from(jsonDecode(formData));
        if (formList.isNotEmpty) {
          nextId = formList.last['id'] + 1;
        }
      });
    }
  }

  void _saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('formList', jsonEncode(formList));
  }

  void _addOrUpdateFormEntry(Map<String, dynamic> entry) {
    setState(() {
      int index = formList.indexWhere((e) => e['id'] == entry['id']);
      if (index == -1) {
        formList.add(entry);
      } else {
        formList[index] = entry;
      }
      _saveFormData();
    });
  }

  void _removeFormEntry(int id) {
    setState(() {
      formList.removeWhere((entry) => entry['id'] == id);
      _saveFormData();
    });
  }

  void _openBottomSheet({Map<String, dynamic>? entry}) {
    int id = entry?['id'] ?? nextId;
    bool isUpdate = entry != null;
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
          onPressed: () {
            print('Update button pressed');
            if (_validateForm(nameController.text, phoneController.text, emailController.text)) {
              print('Form is valid');
              if (isUpdate) {
                print('Updating existing entry with id $id');
                _updateFormEntry(id, {
                  'id': id,
                  'name': nameController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                });
              } else {
                print('Adding new entry with id $id');
                _addOrUpdateFormEntry({
                  'id': id,
                  'name': nameController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                });
                nextId++;
              }
              Get.back();
            } else {
              print('Form is invalid');
              Get.snackbar('Error', 'All fields are required and must be valid!',
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: Text(entry == null ? 'Save' : 'Update'),
        ),
          ],
        ),
      ),
    );
  }
  void _updateFormEntry(int id, Map<String, dynamic> updatedEntry) {
    print('Updating form entry with id $id');
    setState(() {
      int index = formList.indexWhere((e) => e['id'] == id);
      if (index != -1) {
        print('Found existing entry at index $index');
        formList[index] = updatedEntry;
      } else {
        print('No existing entry found with id $id');
      }
      _saveFormData();
    });
  }

  bool _validateForm(String name, String phone, String email) {
    if (name.isEmpty || phone.isEmpty || email.isEmpty) {
      return false;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      return false; // Ensure phone number is 10 digits
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return false; // Basic email validation
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form CRUD')),
      body: SingleChildScrollView(
        child: Column(
          children: [


            SizedBox(
              // height: 100,
              child: formList.isEmpty
                  ? Center(child: Text('No data available'))
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: formList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(formList[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone: ${formList[index]['phone']}'),
                        Text('Email: ${formList[index]['email']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _openBottomSheet(entry: formList[index]),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeFormEntry(formList[index]['id']),
                        ),
                      ],
                    ),
                    leading: Text('ID: ${formList[index]['id']}'),
                  );
                },
              ),
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
}
