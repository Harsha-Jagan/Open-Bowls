import "package:flutter/material.dart";
import "package:frontend/pages/authenticate/login.dart";
import "package:frontend/pages/authenticate/register.dart";

//Authentication Page: let's user to login or sign up
class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 184, 195, 216),
        appBar: AppBar(
          title: const Text("OpenArms Login or Sign Up"),
          backgroundColor: const Color.fromARGB(255, 184, 195, 216),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                  );
                },
                color: const Color.fromARGB(255, 22, 75, 173),
                textColor: Colors.white,
                child: const Text("Login"),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                color: const Color.fromARGB(255, 22, 75, 173),
                textColor: Colors.white,
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ));
  }
}
