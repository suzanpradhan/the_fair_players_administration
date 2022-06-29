part of 'get_all_competitions_bloc.dart';

abstract class GetAllCompetitionsEvent extends Equatable {
  const GetAllCompetitionsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCompetitionFirstAttempt extends GetAllCompetitionsEvent {}

class GetAllCompetitionAttempt extends GetAllCompetitionsEvent {}

class DeleteCompetitionAttempt extends GetAllCompetitionsEvent {
  final CompetitionModel competitionModel;
  const DeleteCompetitionAttempt({required this.competitionModel});

  @override
  List<Object> get props => [competitionModel];
}
