import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/classes/user.dart';
import 'package:frontend/classes/userdata.dart';

class DbService {
  final String? uid;
  DbService({this.uid});

  // user collection ref
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future updateUSerData(
      String fname,
      String lname,
      int age,
      String gender,
      String sexualOrientation,
      String race,
      int durationHomeless,
      bool hasChild,
      bool hasPets,
      bool hasDisabilities,
      bool isVeteran,
      bool useSubstance,
      double weight,
      String height) async {
    return await userCollection.doc(uid).set({
      'fname': fname,
      'lname': lname,
      'age': age,
      'gender': gender,
      'sexualOrientation': sexualOrientation,
      'race': race,
      'durationHomeless': durationHomeless,
      'hasChild': hasChild,
      'hasPets': hasPets,
      'hasDisabilities': hasDisabilities,
      'isVeteran': isVeteran,
      'useSubstance': useSubstance,
      'weight': weight,
      'height': height
    });
  }

  List<user_data> _userdataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<user_data>((doc) {
      return user_data(
          fname: doc.get('fname') ?? '',
          lname: doc.get('lname') ?? '',
          gender: doc.get('gender') ?? '');
    }).toList();
  }

  CustomerData _userDataFromSnap(DocumentSnapshot snapshot) {
    return CustomerData(
        uid: uid,
        fname: snapshot['fname'],
        lname: snapshot['lname'],
        age: snapshot['age'],
        gender: snapshot['gender'],
        sexualOrientation: snapshot['sexualOrientation'],
        race: snapshot['race'],
        durationHomeless: snapshot['durationHomeless'],
        hasChild: snapshot['hasChild'],
        hasPets: snapshot['hasPets'],
        hasDisabilities: snapshot['hasDisabilities'],
        isVeteran: snapshot['isVeteran'],
        useSubstance: snapshot['useSubstance']);
  }

  Stream<List<user_data>> get userData {
    return userCollection.snapshots().map(_userdataFromSnapshot);
  }

  Stream<CustomerData> get dataFromFS {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnap);
  }
}
