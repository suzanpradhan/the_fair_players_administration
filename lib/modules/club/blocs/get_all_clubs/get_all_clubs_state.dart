part of 'get_all_clubs_bloc.dart';

abstract class GetAllClubsState {
  const GetAllClubsState();
}

class GetAllClubsInitial extends GetAllClubsState {}

class GetAllClubsLoading extends GetAllClubsState {}

class GotAllClubsState extends GetAllClubsState {
  final List<ClubModel> listOfClubs;
  final bool hasMore;
  const GotAllClubsState({required this.listOfClubs, required this.hasMore});

  GotAllClubsState addListOfClubs(
      {required List<ClubModel> listOfClubs, bool? hasMore}) {
    if (listOfClubs.isNotEmpty) {
      this.listOfClubs.addAll(listOfClubs);
    }
    return GotAllClubsState(
        listOfClubs: this.listOfClubs, hasMore: listOfClubs.isNotEmpty);
  }

  GotAllClubsState deleteClub({required ClubModel club}) {
    if (listOfClubs.isNotEmpty) {
      listOfClubs.remove(club);
    }
    return GotAllClubsState(listOfClubs: listOfClubs, hasMore: hasMore);
  }
}

class GetAllClubsFailedState extends GetAllClubsState {
  final String errorMessage;
  const GetAllClubsFailedState({required this.errorMessage});
}
