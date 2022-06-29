part of 'get_all_users_bloc.dart';

abstract class GetAllUsersEvent extends Equatable {
  const GetAllUsersEvent();

  @override
  List<Object?> get props => [];
}

class GetAllUsersFirstAttempt extends GetAllUsersEvent {
  final String? searchValue;
  const GetAllUsersFirstAttempt({this.searchValue});

  @override
  List<Object?> get props => [searchValue];
}

class GetAllUsersAttempt extends GetAllUsersEvent {
  final String? searchValue;
  const GetAllUsersAttempt({this.searchValue});

  @override
  List<Object?> get props => [searchValue];
}
