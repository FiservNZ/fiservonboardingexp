// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

import '../../firebase references/firebase_refs.dart';
import '../login_page.dart';
import '../../controllers/manager_functions.dart';

class ManagerView extends StatefulWidget {
  const ManagerView({super.key});

  @override
  _ManagerViewState createState() => _ManagerViewState();
}

class _ManagerViewState extends State<ManagerView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _selectedPosition;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _positions = ['manager', 'developer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Manager View', style: TextStyle(color: fiservColor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // pull reference from the file
              await fireAuth.signOut();
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return LoginPage();
                  },
                ),
                (_) => false,
              );
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(color: fiservColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: fiservColor),
                  ),
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(color: fiservColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: fiservColor),
                  ),
                ),
                obscureText: true,
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(color: fiservColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: fiservColor),
                  ),
                ),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(color: fiservColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: fiservColor),
                  ),
                ),
              ),
              DropdownButton<String>(
                hint: const Text(
                  'Position',
                  style: TextStyle(color: Colors.grey),
                ),
                value: _selectedPosition,
                onChanged: (newValue) {
                  setState(() {
                    _selectedPosition = newValue;
                  });
                },
                items: _positions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String? uid = await signUpWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                    if (uid != null) {
                      saveUserDetails(uid, _firstNameController.text,
                          _lastNameController.text, _selectedPosition!);
                      showDialog(
                        context: _formKey.currentContext!,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Notice:'),
                            content: const Text(
                              'Employee has been added to the database!',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ManagerView()));
}
