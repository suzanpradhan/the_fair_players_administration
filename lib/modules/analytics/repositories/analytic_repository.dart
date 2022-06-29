import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import '../../core/services/firebase_database_service.dart';

class AnalyticRepository {
  static Stream<DatabaseEvent> getAllUsersStream({required double timeszone}) {
    DatabaseReference userReference =
        FirebaseDatabaseService().getReference("Users/Profile");
    return userReference.onValue;
  }

  static Stream<DatabaseEvent> getAllLetsPlayStream(
      {required double timeszone}) {
    return FirebaseDatabaseService()
        .getReference("LetsPlay")
        .orderByChild("date")
        .startAt(timeszone)
        .endAt(DateTime.now().millisecondsSinceEpoch)
        .onValue;
  }

  static Stream<DatabaseEvent> getAllClubStream({required double timeszone}) {
    return FirebaseDatabaseService()
        .getReference("Clubs")
        .orderByChild("createdTime")
        .startAt(timeszone)
        .endAt(DateTime.now().millisecondsSinceEpoch)
        .onValue;
  }

  static Stream<DatabaseEvent> getAllCompetitionStream(
      {required double timeszone}) {
    return FirebaseDatabaseService()
        .getReference("Competitions")
        .orderByChild("createdTime")
        .startAt(timeszone)
        .endAt(DateTime.now().millisecondsSinceEpoch)
        .onValue;
  }

  static Stream<DatabaseEvent> getAllTeamsStream({required double timeszone}) {
    log(DateTime.now().millisecondsSinceEpoch.toString(),
        name: "getAllTeamsStream");
    return FirebaseDatabaseService()
        .getReference("Teams")
        .orderByChild("createdTime")
        .startAt(timeszone)
        .endAt(DateTime.now().millisecondsSinceEpoch)
        .onValue;
  }

  // static Stream<DatabaseEvent> getAllPostsStream({required double timeszone}) {
  //   return FirebaseDatabaseService()
  //       .getReference("Posts")
  //       .orderByChild("createdTime")
  //       .startAt(timeszone)
  //       .endAt(DateTime.now().millisecondsSinceEpoch)
  //       .onValue;
  // }
}
