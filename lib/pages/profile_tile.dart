import 'package:flutter/material.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/core/notifiers.dart';
import 'package:frontend/pages/authenticate/auth.dart';

class Loading extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), actions: <Widget>[
        IconButton(
            onPressed: () async {
              await _auth.SignOut();
            },
            icon: const Icon(Icons.person),
            tooltip: "Sign Out")
      ]),
      body: const Column(
        children: [
          CircleAvatar(
              backgroundImage: AssetImage('images/yeah.png'), radius: 60),
          SizedBox(
            height: kDouble20,
          ),
          ListTile(
              title: Text('Firstname Lastname'), leading: Icon(Icons.person)),
          ListTile(title: Text('email@email.com'), leading: Icon(Icons.email)),
          ListTile(title: Text('website123.com'), leading: Icon(Icons.web))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            isDarkMode.value = !isDarkMode.value;
          },
          child: const Icon(Icons.dark_mode)),
    );
  }
}
