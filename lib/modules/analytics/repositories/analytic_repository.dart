import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import '../../core/services/firebase_database_service.dart';

class AnalyticRepository {
  static Stream<DatabaseEvent> getAllUsersStream({double? timeszone}) {
    DatabaseReference userReference =
        FirebaseDatabaseService().getReference("Users/Profile");
    if (timeszone != null) {
      return userReference
          .orderByChild("createdAt")
          .startAt(timeszone)
          .endAt(DateTime.now().millisecondsSinceEpoch)
          .onValue;
    } else {
      return userReference.onValue;
    }
  }

  static Stream<DatabaseEvent> getAllLetsPlayStream({double? timeszone}) {
    if (timeszone != null) {
      return FirebaseDatabaseService()
          .getReference("LetsPlay")
          .orderByChild("date")
          .startAt(timeszone)
          .endAt(DateTime.now().millisecondsSinceEpoch)
          .onValue;
    } else {
      return FirebaseDatabaseService().getReference("LetsPlay").onValue;
    }
  }

  static Stream<DatabaseEvent> getAllClubStream({double? timeszone}) {
    if (timeszone != null) {
      return FirebaseDatabaseService()
          .getReference("Clubs")
          .orderByChild("createdTime")
          .startAt(timeszone)
          .endAt(DateTime.now().millisecondsSinceEpoch)
          .onValue;
    } else {
      return FirebaseDatabaseService().getReference("Clubs").onValue;
    }
  }

  static Stream<DatabaseEvent> getAllCompetitionStream({double? timeszone}) {
    if (timeszone != null) {
      return FirebaseDatabaseService()
          .getReference("Competitions")
          .orderByChild("createdTime")
          .startAt(timeszone)
          .endAt(DateTime.now().millisecondsSinceEpoch)
          .onValue;
    } else {
      return FirebaseDatabaseService().getReference("Competitions").onValue;
    }
  }

  static Stream<DatabaseEvent> getAllTeamsStream({double? timeszone}) {
    log(DateTime.now().millisecondsSinceEpoch.toString(),
        name: "getAllTeamsStream");
    if (timeszone != null) {
      return FirebaseDatabaseService()
          .getReference("Teams")
          .orderByChild("createdTime")
          .startAt(timeszone)
          .endAt(DateTime.now().millisecondsSinceEpoch)
          .onValue;
    } else {
      return FirebaseDatabaseService().getReference("Teams").onValue;
    }
  }

  Future<Map> getMontlyUsers() async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Users")
        .child("Profile")
        .get();
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    const List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec",
    ];

    List<List> mapOfMontlyActiveUsers = [];
    int totalUsersOfThisMonth = 0;

    for (var i = 0; i < month; i++) {
      mapOfMontlyActiveUsers
          .add([months[i], _getActiveUsersByMonth(year, i + 1, snapshot)]);
      if (i == month - 1) {
        totalUsersOfThisMonth = mapOfMontlyActiveUsers[i][1];
      }
    }
    Map data = {
      "listOfActiveUsers": mapOfMontlyActiveUsers,
      "totalUsersOfThisMonth": totalUsersOfThisMonth
    };
    return data;
  }

  int _getActiveUsersByMonth(int year, int month, DataSnapshot snapshot) {
    return snapshot.children.where((element) {
      if (element.hasChild("loginHistory")) {
        for (var data in element.child("loginHistory").children) {
          if ((data.child("dateTime").value != null) &&
              (data.child("dateTime").value as double >=
                  DateTime(year, month, 1).millisecondsSinceEpoch.toDouble()) &&
              (data.child("dateTime").value as double <=
                  DateTime(year, month, 30)
                      .millisecondsSinceEpoch
                      .toDouble())) {
            return true;
          }
        }
        return false;
      } else {
        return false;
      }
    }).length;
  }

  Future<Map> getNewUsers() async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Users")
        .child("Profile")
        .get();
    int weekday = DateTime.now().weekday;
    const List<String> weekdays = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun",
    ];

    List<List> mapOfWeekDayNewUsers = [];
    int totalNewUsers = 0;

    for (var i = weekday; i > 0; i--) {
      int totaNewUsers = _getNewUsersByWeek(i, snapshot);
      mapOfWeekDayNewUsers.add([weekdays[i - 1], totaNewUsers]);
      totalNewUsers = totaNewUsers;
    }
    Map data = {
      "listOfNewUsers": mapOfWeekDayNewUsers.reversed.toList(),
      "totalNewUsers": totalNewUsers
    };
    return data;
  }

  int _getNewUsersByWeek(int weekDay, DataSnapshot snapshot) {
    return snapshot.children.where((element) {
      if ((element.child("createdAt").value != null) &&
          (DateTime.now()
                  .subtract(Duration(days: weekDay))
                  .difference(DateTime.fromMillisecondsSinceEpoch(
                      (element.child("createdAt").value as double).toInt()))
                  .inDays ==
              0)) {
        return true;
      }
      return false;
    }).length;
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
