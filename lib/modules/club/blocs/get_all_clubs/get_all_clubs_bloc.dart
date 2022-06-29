import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/club_model.dart';
import '../../repositories/club_repository.dart';

part 'get_all_clubs_event.dart';
part 'get_all_clubs_state.dart';

class GetAllClubsBloc extends Bloc<GetAllClubsEvent, GetAllClubsState> {
  ClubRepository clubRepository;
  String? lastDocumentKey;
  GetAllClubsBloc({required this.clubRepository})
      : super(GetAllClubsInitial()) {
    on<GetAllClubsEvent>((event, emit) {});
    on<GetAllClubsFirstAttempt>((event, emit) async {
      emit(GetAllClubsLoading());
      List<ClubModel> listOfClubs = await getListOfClubs();
      emit(GotAllClubsState(
          listOfClubs: listOfClubs.reversed.toList(), hasMore: true));
    });
    on<GetAllClubsAttempt>((event, emit) async {
      List<ClubModel> listOfClubs = await getListOfClubs();
      if (state is GotAllClubsState) {
        emit((state as GotAllClubsState).addListOfClubs(
            listOfClubs: listOfClubs.reversed.toList(),
            hasMore: listOfClubs.isNotEmpty));
      } else {
        emit(GotAllClubsState(
            listOfClubs: listOfClubs.reversed.toList(), hasMore: true));
      }
    });
    on<DeleteClubAttempt>((event, emit) => _handleDeleteClubEvent(event, emit));
  }

  Future<List<ClubModel>> getListOfClubs() async {
    DataSnapshot listOfClubsSnapshot =
        await clubRepository.getAllClubsSnapshot(lastDocumentKey);
    List<ClubModel> listOfClubs = listOfClubsSnapshot.children
        .map((DataSnapshot snapshot) => ClubModel.fromJson(
            snapshot.value as Map<String, dynamic>, snapshot.key))
        .toList();
    if (listOfClubs.isNotEmpty) {
      lastDocumentKey = listOfClubs[0].uid;
    }
    return listOfClubs;
  }

  _handleDeleteClubEvent(
      DeleteClubAttempt event, Emitter<GetAllClubsState> emit) async {
    clubRepository.deleteModel(event.clubModel.uid);
    emit((state as GotAllClubsState).deleteClub(club: event.clubModel));
  }
}
