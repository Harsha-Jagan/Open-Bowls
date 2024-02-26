import 'package:flutter/material.dart';

//For firebase user
class Customer {
  final String? uid;
  Customer({this.uid});
}

class CustomerData {
  final String? uid;
  final String? fname;
  final String? lname;
  final int? age;
  final String? gender;
  final String? sexualOrientation;
  final String? race;
  final int? durationHomeless;
  final bool? hasChild;
  final bool? hasPets;
  final bool? hasDisabilities;
  final bool? isVeteran;
  final bool? useSubstance;
  final double? weight;
  final String? height;

  CustomerData(
      {this.uid,
      this.fname,
      this.lname,
      this.age,
      this.gender,
      this.sexualOrientation,
      this.race,
      this.durationHomeless,
      this.hasChild,
      this.hasPets,
      this.hasDisabilities,
      this.isVeteran,
      this.useSubstance,
      this.weight,
      this.height});

  Map<String, dynamic> toJson() => {
        'age': age,
        'durationHomeless': durationHomeless,
        'fname': fname,
        'gender': gender,
        'hasChild': hasChild,
        'hasDisabilities': hasDisabilities,
        'hasPets': hasPets,
        'height': height,
        'isVeteran': isVeteran,
        'lname': lname,
        'race': race,
        'sexualOrientation': sexualOrientation,
        'useSubstance': useSubstance,
        'weight': weight,
      };
}
