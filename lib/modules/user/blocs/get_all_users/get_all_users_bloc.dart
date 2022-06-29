import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

part 'get_all_users_event.dart';
part 'get_all_users_state.dart';

class GetAllUsersBloc extends Bloc<GetAllUsersEvent, GetAllUsersState> {
  UserRepository userRepository;
  String? lastDocumentKey;
  GetAllUsersBloc({required this.userRepository})
      : super(GetAllUsersInitial()) {
    on<GetAllUsersEvent>((event, emit) {});
    on<GetAllUsersFirstAttempt>((event, emit) async {
      emit(GetAllUsersLoading());
      List<UserModel> listOfUsers = await getListOfUsers(event.searchValue);
      emit(GotAllUsersState(
          listOfUsers: listOfUsers.reversed.toList(), hasMore: true));
    });
    on<GetAllUsersAttempt>((event, emit) async {
      List<UserModel> listOfUsers = await getListOfUsers(event.searchValue);
      if (state is GotAllUsersState) {
        emit((state as GotAllUsersState).addListOfUsers(
            listOfUsers: listOfUsers.reversed.toList(),
            hasMore: listOfUsers.isNotEmpty));
      } else {
        emit(GotAllUsersState(
            listOfUsers: listOfUsers.reversed.toList(), hasMore: true));
      }
    });
  }

  Future<List<UserModel>> getListOfUsers(String? searchValue) async {
    DataSnapshot listOfUsersSnapshot =
        await userRepository.getUserSnapshot(lastDocumentKey, searchValue);
    List<UserModel> listOfUsers = listOfUsersSnapshot.children
        .map((DataSnapshot snapshot) =>
            UserModel.fromJson(snapshot.value as Map<String, dynamic>))
        .toList();
    if (listOfUsers.isNotEmpty) {
      lastDocumentKey = listOfUsers[0].uid;
    }
    return listOfUsers;
  }
}
