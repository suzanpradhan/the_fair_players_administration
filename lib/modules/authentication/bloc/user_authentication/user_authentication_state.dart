part of 'user_authentication_bloc.dart';

class UserAuthenticationState extends Equatable {
  final User? user;
  const UserAuthenticationState({this.user});

  @override
  List<Object?> get props => [user];
}

// class UserAuthenticationInitial extends UserAuthenticationState {}
