import 'package:frontend/classes/user.dart';
import 'package:frontend/pages/authenticate/auth.dart';
import 'package:frontend/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

//Runs Wrapper
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Customer?>.value(
        catchError: (_, __) => null,
        value: AuthService().per,
        initialData: null,
        child: MaterialApp(home: Wrapper()));
  }
}
