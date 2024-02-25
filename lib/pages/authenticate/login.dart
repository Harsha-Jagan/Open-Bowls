import 'package:frontend/pages/authenticate/auth.dart';
import 'package:frontend/pages/home_wrapper.dart';
import 'package:flutter/material.dart';

//Login Page
//Form Validated
class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 195, 216),
      appBar: AppBar(
        title: Text(
          "OpenArms  Login",
          textAlign: TextAlign.right,
        ),
        backgroundColor: Color.fromARGB(255, 184, 195, 216),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Login",
              style: TextStyle(
                  fontSize: 35,
                  color: Color.fromARGB(255, 1, 1, 12),
                  fontWeight: FontWeight.bold)),
          Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Please Enter your email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    validator: (val) =>
                        val != null && val.isEmpty ? 'Enter an email' : null,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Please enter password",
                      prefixIcon: Icon(Icons.password),
                    ),
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    validator: (val) => val != null && val.length <= 8
                        ? 'Enter a password that is atleast characters long'
                        : null,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (!_formkey.currentState!.validate()) {
                        print("");
                      } else {
                        dynamic res =
                            await _auth.loginEmailAndPassword(email, password);
                        //checking for error, you can remove this
                        if (res == null) {
                          setState(() => error = "Error");
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Wraphome()),
                          );
                        }
                      }
                    },
                    child: Text("Login"),
                    color: Color.fromARGB(255, 22, 75, 173),
                    textColor: Colors.white,
                  ),
                  //checking for sign-in error
                  Text(error),
                  SizedBox(
                    height: 80,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Don't have an account? Click here!"),
                    color: Color.fromARGB(255, 184, 195, 216),
                    textColor: Colors.black,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
