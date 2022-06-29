import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/team_model.dart';
import '../../repositories/team_repository.dart';

part 'get_all_teams_event.dart';
part 'get_all_teams_state.dart';

class GetAllTeamsBloc extends Bloc<GetAllTeamsEvent, GetAllTeamsState> {
  TeamRepository teamRepository;
  String? lastDocumentKey;
  GetAllTeamsBloc({required this.teamRepository})
      : super(GetAllTeamsInitial()) {
    on<GetAllTeamsEvent>((event, emit) {});
    on<GetAllTeamsFirstAttempt>((event, emit) async {
      emit(GetAllTeamsLoading());
      List<TeamModel> listOfTeams = await getListOfTeams();
      emit(GotAllTeamsState(
          listOfTeams: listOfTeams.reversed.toList(), hasMore: true));
    });
    on<GetAllTeamsAttempt>((event, emit) async {
      List<TeamModel> listOfTeams = await getListOfTeams();
      if (state is GotAllTeamsState) {
        emit((state as GotAllTeamsState).addListOfTeams(
            listOfTeams: listOfTeams.reversed.toList(),
            hasMore: listOfTeams.isNotEmpty));
      } else {
        emit(GotAllTeamsState(
            listOfTeams: listOfTeams.reversed.toList(), hasMore: true));
      }
    });
    on<DeleteTeamAttempt>((event, emit) => _handleDeleteTeamEvent(event, emit));
  }

  Future<List<TeamModel>> getListOfTeams() async {
    DataSnapshot listOfTeamsSnapshot =
        await teamRepository.getAllTeamsSnapshot(lastDocumentKey);
    List<TeamModel> listOfTeams = listOfTeamsSnapshot.children
        .map((DataSnapshot snapshot) => TeamModel.fromJson(
            snapshot.value as Map<String, dynamic>, snapshot.key))
        .toList();

    if (listOfTeams.isNotEmpty) {
      lastDocumentKey = listOfTeams[0].uid;
    }
    return listOfTeams;
  }

  _handleDeleteTeamEvent(
      DeleteTeamAttempt event, Emitter<GetAllTeamsState> emit) async {
    teamRepository.deleteModel(event.teamModel.uid);
    emit((state as GotAllTeamsState).deleteTeam(team: event.teamModel));
  }
}
