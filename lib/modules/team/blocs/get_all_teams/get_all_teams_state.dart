part of 'get_all_teams_bloc.dart';

abstract class GetAllTeamsState {
  const GetAllTeamsState();
}

class GetAllTeamsInitial extends GetAllTeamsState {}

class GetAllTeamsLoading extends GetAllTeamsState {}

class GotAllTeamsState extends GetAllTeamsState {
  final List<TeamModel> listOfTeams;
  final bool hasMore;
  const GotAllTeamsState({required this.listOfTeams, required this.hasMore});

  GotAllTeamsState addListOfTeams(
      {required List<TeamModel> listOfTeams, bool? hasMore}) {
    if (listOfTeams.isNotEmpty) {
      this.listOfTeams.addAll(listOfTeams);
    }
    return GotAllTeamsState(
        listOfTeams: this.listOfTeams, hasMore: listOfTeams.isNotEmpty);
  }

  GotAllTeamsState deleteTeam({required TeamModel team}) {
    if (listOfTeams.isNotEmpty) {
      listOfTeams.remove(team);
    }
    return GotAllTeamsState(listOfTeams: listOfTeams, hasMore: hasMore);
  }
}

class GetAllTeamsFailedState extends GetAllTeamsState {
  final String errorMessage;
  const GetAllTeamsFailedState({required this.errorMessage});
}
