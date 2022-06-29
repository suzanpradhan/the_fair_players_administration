part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAttemptEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginAttemptEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
