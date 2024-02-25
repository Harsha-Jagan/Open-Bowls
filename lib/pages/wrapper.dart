import 'package:frontend/classes/user.dart';
import 'package:frontend/pages/authenticate/authentication.dart';
import "package:flutter/material.dart";
import 'package:frontend/pages/home_wrapper.dart';
import 'package:provider/provider.dart';

//Wrapper: runs the Authenticate page
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate
    final person = Provider.of<Customer?>(context);
    if (person == null) {
      return Authenticate();
    } else {
      return Wraphome();
    }
  }
}
