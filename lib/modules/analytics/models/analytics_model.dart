import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/analytics/repositories/analytic_repository.dart';

class AnalyticsModel {
  final String title;
  final Stream<DatabaseEvent> Function({double? timeszone}) stream;

  const AnalyticsModel({required this.title, required this.stream});
}

List<AnalyticsModel> listOfAnalysis = [
  const AnalyticsModel(
    title: "Users",
    stream: AnalyticRepository.getAllUsersStream,
  ),
  const AnalyticsModel(
    title: "Let's play",
    stream: AnalyticRepository.getAllLetsPlayStream,
  ),
  const AnalyticsModel(
    title: "Club",
    stream: AnalyticRepository.getAllClubStream,
  ),
  const AnalyticsModel(
    title: "Team",
    stream: AnalyticRepository.getAllTeamsStream,
  ),
  const AnalyticsModel(
    title: "Competition",
    stream: AnalyticRepository.getAllCompetitionStream,
  ),
  // const AnalyticsModel(
  //   title: "Posts",
  //   stream: AnalyticRepository.getAllPostsStream,
  // ),
  // AnalyticsModel(
  //   title: "Connection",
  //   stream: AnalyticRepository.getAllUsersStream(),
  // ),
  // AnalyticsModel(
  //   title: "Opened dialog boxes",
  //   stream: AnalyticRepository.getAllUsersStream(),
  // ),
  // AnalyticsModel(
  //   title: "post/share",
  //   stream: AnalyticRepository.getAllUsersStream(),
  // ),
];
