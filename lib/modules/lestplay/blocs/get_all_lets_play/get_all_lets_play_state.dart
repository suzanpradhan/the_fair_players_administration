part of 'get_all_lets_play_bloc.dart';

abstract class GetAllLetsPlayState {
  const GetAllLetsPlayState();
}

class GetAllLetsPlayInitial extends GetAllLetsPlayState {}

class GetAllLetsPlayLoading extends GetAllLetsPlayState {}

class GotAllLetsPlayState extends GetAllLetsPlayState {
  final List<LetsPlayModel> listOfLetsPlay;
  final bool hasMore;
  const GotAllLetsPlayState(
      {required this.listOfLetsPlay, required this.hasMore});

  GotAllLetsPlayState addListOfLetsPlay(
      {required List<LetsPlayModel> listOfLetsPlay, bool? hasMore}) {
    if (listOfLetsPlay.isNotEmpty) {
      this.listOfLetsPlay.addAll(listOfLetsPlay);
    }
    return GotAllLetsPlayState(
        listOfLetsPlay: this.listOfLetsPlay,
        hasMore: listOfLetsPlay.isNotEmpty);
  }

  GotAllLetsPlayState deleteCompetition(
      {required LetsPlayModel letsPlayModel}) {
    if (listOfLetsPlay.isNotEmpty) {
      listOfLetsPlay.remove(letsPlayModel);
    }
    return GotAllLetsPlayState(
        listOfLetsPlay: listOfLetsPlay, hasMore: hasMore);
  }
}

class GetAllLetsPlayFailedState extends GetAllLetsPlayState {
  final String errorMessage;
  const GetAllLetsPlayFailedState({required this.errorMessage});
}
