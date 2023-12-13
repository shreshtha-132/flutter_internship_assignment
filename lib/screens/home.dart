import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static String id = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Uri url = Uri.parse("https://dummy.restapiexample.com/api/v1/employees");
  Uri addurl = Uri.parse("https://dummy.restapiexample.com/api/v1/create");
  var response;
  var addResponse;
  List<dynamic> employees = [];

  String name = "";
  String age = "";
  String salary = "";

  TextEditingController _addEmp = TextEditingController();

  Future<void> getData() async {
    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        employees = responseData['data']; // Extract 'data' from the response

        print(employees[0]['employee_name']);
      }
    } catch (e) {
      print("error fetching data : $e");
      employees = [];
    }
  }

  Future<void> addEmployee() async {
    try {
      Map<String, dynamic> employeeData = {
        "name": name,
        "salary": salary,
        "age": age,
      };

      String jsonData = json.encode(employeeData);

      addResponse = await http.post(
        addurl,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (addResponse.statusCode == 200) {
        await getData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Employee added successfully'),
          ),
        );

        Map<String, dynamic> responseData = json.decode(addResponse.body);
        print(responseData['data']);
        setState(() {
          print("updated");
        });
      } else {
        print("Failed to add employee. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding employee: $e");
    }
  }

  void initData() async {
    await getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      employees[index]['employee_name'],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Age: ${employees[index]['employee_age']}"), // Employee age
                        Text(
                            "Salary: ${employees[index]['employee_salary']}"), // Employee salary
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Enter employee Details"),
                      content: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: "name"),
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "salary"),
                            onChanged: (value) {
                              salary = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "age"),
                            onChanged: (value) {
                              age = value;
                            },
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            print('Name: $name, Salary: $salary, Age: $age');
                            addEmployee();
                            Navigator.of(context).pop();
                          },
                          child: Text('Submit'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the AlertDialog
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
                // do smth
              },
              child: Text("Press Me to add record"),
            )
          ],
        ),
      ),
    );
  }
}
