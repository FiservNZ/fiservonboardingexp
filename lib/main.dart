import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleLogin(BuildContext context) {
    // get the information
    String username = usernameController.text;
    String password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both username and password.')),
      );
    } else {
      print('Username: $username, Password: $password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate the user to the Home page
                _handleLogin(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
