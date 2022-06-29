import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/competition/models/competition_model.dart';
import 'package:the_fair_players_administration/modules/competition/repositories/competitions_repository.dart';

import '../../models/competition_model.dart';

part 'get_all_competitions_event.dart';
part 'get_all_competitions_state.dart';

class GetAllCompetitionsBloc
    extends Bloc<GetAllCompetitionsEvent, GetAllCompetitionState> {
  CompetitionsRepository competitionsRepository;
  String? lastDocumentKey;
  GetAllCompetitionsBloc({required this.competitionsRepository})
      : super(GetAllCompetitionInitial()) {
    on<GetAllCompetitionsEvent>((event, emit) {});
    on<GetAllCompetitionFirstAttempt>((event, emit) async {
      emit(GetAllCompetitionLoading());
      List<CompetitionModel> listOfCompetitions = await getListOfCompetitions();
      emit(GotAllCompetitionState(
          listOfCompetitions: listOfCompetitions.reversed.toList(),
          hasMore: true));
    });
    on<GetAllCompetitionAttempt>((event, emit) async {
      List<CompetitionModel> listOfCompetitions = await getListOfCompetitions();
      if (state is GotAllCompetitionState) {
        emit((state as GotAllCompetitionState).addListOfCompetitions(
            listOfCompetitions: listOfCompetitions.reversed.toList(),
            hasMore: listOfCompetitions.isNotEmpty));
      } else {
        emit(GotAllCompetitionState(
            listOfCompetitions: listOfCompetitions.reversed.toList(),
            hasMore: true));
      }
    });
    on<DeleteCompetitionAttempt>(
        (event, emit) => _handleDeleteCompetitionsEvent(event, emit));
  }

  Future<List<CompetitionModel>> getListOfCompetitions() async {
    DataSnapshot listOfCompetitionsSnapshot = await competitionsRepository
        .getAllCompetitionsSnapshot(lastDocumentKey);
    List<CompetitionModel> listOfCompetitions = listOfCompetitionsSnapshot
        .children
        .map((DataSnapshot snapshot) => CompetitionModel.fromJson(
            snapshot.value as Map<String, dynamic>, snapshot.key))
        .toList();
    if (listOfCompetitions.isNotEmpty) {
      lastDocumentKey = listOfCompetitions[0].uid;
    }
    return listOfCompetitions;
  }

  _handleDeleteCompetitionsEvent(DeleteCompetitionAttempt event,
      Emitter<GetAllCompetitionState> emit) async {
    competitionsRepository.deleteModel(event.competitionModel.uid);
    emit((state as GotAllCompetitionState)
        .deleteCompetition(competition: event.competitionModel));
  }
}
