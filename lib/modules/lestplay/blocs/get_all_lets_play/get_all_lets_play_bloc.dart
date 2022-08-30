import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/lestplay/models/letsplay_model.dart';
import 'package:the_fair_players_administration/modules/lestplay/repositories/lets_play_repository.dart';

part 'get_all_lets_play_event.dart';
part 'get_all_lets_play_state.dart';

class GetAllLetsPlayBloc
    extends Bloc<GetAllLetsPlayEvent, GetAllLetsPlayState> {
  LetsPlayRepository letsPlayRepository;
  String? lastDocumentKey;
  GetAllLetsPlayBloc({required this.letsPlayRepository})
      : super(GetAllLetsPlayInitial()) {
    on<GetAllLetsPlayEvent>((event, emit) {});
    on<GetAllLetsPlayFirstAttempt>((event, emit) async {
      emit(GetAllLetsPlayLoading());
      List<LetsPlayModel> listOfLetsPlay = await getListOfLetsPlay();
      emit(GotAllLetsPlayState(
          listOfLetsPlay: listOfLetsPlay.reversed.toList(), hasMore: true));
    });
    on<GetAllLetsPlayAttempt>((event, emit) async {
      List<LetsPlayModel> listOfLetsPlay = await getListOfLetsPlay();
      if (state is GotAllLetsPlayState) {
        emit((state as GotAllLetsPlayState).addListOfLetsPlay(
            listOfLetsPlay: listOfLetsPlay.reversed.toList(),
            hasMore: listOfLetsPlay.isNotEmpty));
      } else {
        emit(GotAllLetsPlayState(
            listOfLetsPlay: listOfLetsPlay.reversed.toList(), hasMore: true));
      }
    });
    on<DeleteLetsPlayAttempt>(
        (event, emit) => _handleDeleteCompetitionsEvent(event, emit));
  }

  Future<List<LetsPlayModel>> getListOfLetsPlay() async {
    DataSnapshot listOfLetsPlaySnapshot =
        await letsPlayRepository.getAllLetsPlaySnapshot(lastDocumentKey);
    List<LetsPlayModel> listOfLetsPlay = listOfLetsPlaySnapshot.children
        .map((DataSnapshot snapshot) => LetsPlayModel.fromJson(
            snapshot.value as Map<String, dynamic>, snapshot.key))
        .toList();
    if (listOfLetsPlay.isNotEmpty) {
      lastDocumentKey = listOfLetsPlay[0].uid;
    }
    return listOfLetsPlay;
  }

  _handleDeleteCompetitionsEvent(
      DeleteLetsPlayAttempt event, Emitter<GetAllLetsPlayState> emit) async {
    letsPlayRepository.deleteModel(key: event.letsPlayModel.uid);
    emit((state as GotAllLetsPlayState)
        .deleteCompetition(letsPlayModel: event.letsPlayModel));
  }
}
