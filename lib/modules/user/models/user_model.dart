import 'dart:developer';

import 'package:intl/intl.dart';

class UserModel {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? country;
  final String? town;
  final String? image;
  final DateTime? dateOfBirth;
  final double? latitude;
  final double? longitude;
  final bool? onlineStatus;
  final int? totalCompetitions;
  final int? totalTeams;
  final int? totalClubs;

  const UserModel(
      {this.country,
      this.dateOfBirth,
      this.email,
      this.firstName,
      this.gender,
      this.image,
      this.lastName,
      this.latitude,
      this.longitude,
      this.onlineStatus,
      this.totalClubs,
      this.totalCompetitions,
      this.totalTeams,
      this.town,
      this.uid});

  factory UserModel.fromJson(Map<String, dynamic> jsonMapData) {
    return UserModel(
        uid: jsonMapData["uid"],
        firstName: jsonMapData["firstName"],
        lastName: jsonMapData["lastName"],
        country: jsonMapData["country"],
        dateOfBirth: null,
        email: jsonMapData["email"],
        gender: jsonMapData["gender"],
        image: jsonMapData["image"],
        latitude: jsonMapData["latitude"],
        longitude: jsonMapData["longitude"],
        onlineStatus: jsonMapData["onlineStatus"],
        totalClubs: jsonMapData["totalClubs"],
        totalCompetitions: jsonMapData["totalCompetitions"],
        totalTeams: jsonMapData["totalTeams"],
        town: jsonMapData["town"]);
  }
}
