part of 'get_all_teams_bloc.dart';

abstract class GetAllTeamsEvent extends Equatable {
  const GetAllTeamsEvent();

  @override
  List<Object> get props => [];
}

class GetAllTeamsFirstAttempt extends GetAllTeamsEvent {}

class GetAllTeamsAttempt extends GetAllTeamsEvent {}

class DeleteTeamAttempt extends GetAllTeamsEvent {
  final TeamModel teamModel;
  const DeleteTeamAttempt({required this.teamModel});

  @override
  List<Object> get props => [teamModel];
}
