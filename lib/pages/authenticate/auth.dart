import 'package:frontend/classes/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/pages/services/database.dart';

//Sign in/Register user with email and password, enable Email and password authentication in your firebase project online
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create customer object
  Customer? _userfromFB(User per) {
    return per != null ? Customer(uid: per.uid) : null;
  }

  Stream<Customer?> get per {
    return _auth.authStateChanges().map((User? per) => _userfromFB(per!));
  }

  //register with email and password
  Future registerEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? person = result.user;

      //create a new document for the user using uid
      await DbService(uid: person!.uid).updateUSerData(
          'fname',
          'lname',
          0,
          'gender',
          'sexualOrientation',
          'race',
          0,
          false,
          false,
          false,
          false,
          false,
          0.0,
          'height');
      return _userfromFB(person!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Stream
  //sign in with email and password
  Future loginEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? person = result.user;
      return _userfromFB(person!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
