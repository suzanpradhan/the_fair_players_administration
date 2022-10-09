part of 'get_all_users_bloc.dart';

abstract class GetAllUsersState {
  const GetAllUsersState();
}

class GetAllUsersInitial extends GetAllUsersState {}

class GetAllUsersLoading extends GetAllUsersState {}

class GotAllUsersState extends GetAllUsersState {
  final List<UserModel> listOfUsers;
  final bool hasMore;

  const GotAllUsersState({required this.listOfUsers, required this.hasMore});

  GotAllUsersState addListOfUsers(
      {required List<UserModel> listOfUsers, bool? hasMore}) {
    if (listOfUsers.isNotEmpty) {
      this.listOfUsers.addAll(listOfUsers);
    }
    return GotAllUsersState(
        listOfUsers: this.listOfUsers, hasMore: listOfUsers.isNotEmpty);
  }

  GotAllUsersState deleteTeam({required UserModel team}) {
    if (listOfUsers.isNotEmpty) {
      listOfUsers.remove(team);
    }
    return GotAllUsersState(listOfUsers: listOfUsers, hasMore: hasMore);
  }
}

class GetAllUsersFailedState extends GetAllUsersState {
  final String errorMessage;

  const GetAllUsersFailedState({required this.errorMessage});
}
