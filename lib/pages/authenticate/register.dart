import 'package:frontend/pages/authenticate/profile_setup_one.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/authenticate/auth.dart';

//Register Page
//Form Validated
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _ResgisterState();
}

class _ResgisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String repassword = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 195, 216),
      appBar: AppBar(
        title: const Text(
          "openbowls Sign Up",
        ),
        backgroundColor: const Color.fromARGB(255, 184, 195, 216),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("Create Account",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 1, 1, 12),
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText:
                          "Please enter password that is atleast 8 characters long",
                      prefixIcon: Icon(Icons.password),
                    ),
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    validator: (val) => val != null && val.length <= 8
                        ? 'Enter a password that is atleast 8 characters long'
                        : null,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Please confirm your password",
                      prefixIcon: Icon(Icons.password),
                    ),
                    onChanged: (val) {
                      setState(() => repassword = val);
                    },
                    validator: (val) => val != null && val != password
                        ? 'Enter the password typed above'
                        : null,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (!_formkey.currentState!.validate()) {
                        print("");
                      } else {
                        dynamic res = await _auth.registerEmailAndPassword(
                            email, password);
                        //checking for error, you can remove this
                        if (res == null) {
                          setState(() => error = "Error");
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CompleteProfOne()),
                        );
                      }
                    },
                    color: const Color.fromARGB(255, 22, 75, 173),
                    textColor: Colors.white,
                    child: const Text("Sign Up"),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: const Color.fromARGB(255, 184, 195, 216),
                    textColor: Colors.black,
                    child: const Text("Already have an account? Click here!"),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
