//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/classes/user.dart';
import 'package:frontend/classes/userdata.dart';
import 'package:frontend/core/constants.dart';
import 'package:frontend/core/notifiers.dart';
import 'package:frontend/pages/authenticate/auth.dart';
import 'package:frontend/pages/profile_tile.dart';
import 'package:frontend/pages/services/database.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  //const ProfilePage({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Customer?>(context);
    return StreamBuilder<CustomerData>(
        stream: DbService(uid: person!.uid).dataFromFS,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomerData? custdata = snapshot.data;
            String var1 = custdata!.fname.toString();
            String var2 = custdata!.lname.toString();
            String var3 = custdata!.gender.toString();
            int? var4 = custdata!.age;
            return Scaffold(
              appBar: AppBar(title: const Text('Profile'), actions: <Widget>[
                IconButton(
                    onPressed: () async {
                      await _auth.SignOut();
                    },
                    icon: const Icon(Icons.person),
                    tooltip: "Sign Out")
              ]),
              body: Column(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage('images/yeah.png'),
                      radius: 60),
                  SizedBox(
                    height: kDouble20,
                  ),
                  ListTile(
                      leading: Icon(Icons.person),
                      title: Text('First Name: $var1')),
                  ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('Last Name: $var2')),
                  ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('Gender: $var3')),
                  ListTile(
                      leading: const Icon(Icons.date_range),
                      title: Text('Age: $var4'))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    isDarkMode.value = !isDarkMode.value;
                  },
                  child: const Icon(Icons.dark_mode)),
            );
          } else {
            return Loading();
          }
        });
  }
}
