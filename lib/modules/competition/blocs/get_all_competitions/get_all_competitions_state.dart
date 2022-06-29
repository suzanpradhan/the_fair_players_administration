part of 'get_all_competitions_bloc.dart';

abstract class GetAllCompetitionState {
  const GetAllCompetitionState();
}

class GetAllCompetitionInitial extends GetAllCompetitionState {}

class GetAllCompetitionLoading extends GetAllCompetitionState {}

class GotAllCompetitionState extends GetAllCompetitionState {
  final List<CompetitionModel> listOfCompetitions;
  final bool hasMore;
  const GotAllCompetitionState(
      {required this.listOfCompetitions, required this.hasMore});

  GotAllCompetitionState addListOfCompetitions(
      {required List<CompetitionModel> listOfCompetitions, bool? hasMore}) {
    if (listOfCompetitions.isNotEmpty) {
      this.listOfCompetitions.addAll(listOfCompetitions);
    }
    return GotAllCompetitionState(
        listOfCompetitions: this.listOfCompetitions,
        hasMore: listOfCompetitions.isNotEmpty);
  }

  GotAllCompetitionState deleteCompetition(
      {required CompetitionModel competition}) {
    if (listOfCompetitions.isNotEmpty) {
      listOfCompetitions.remove(competition);
    }
    return GotAllCompetitionState(
        listOfCompetitions: listOfCompetitions, hasMore: hasMore);
  }
}

class GetAllCompetitionFailedState extends GetAllCompetitionState {
  final String errorMessage;
  const GetAllCompetitionFailedState({required this.errorMessage});
}
