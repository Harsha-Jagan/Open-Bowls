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
}
