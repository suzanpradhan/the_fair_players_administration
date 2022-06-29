import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:the_fair_players_administration/modules/authentication/services/firebase_authentication_service.dart';
import 'package:the_fair_players_administration/modules/core/error_handling/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuthenticationService firebaseAuthenticationService;
  LoginBloc({required this.firebaseAuthenticationService})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginAttemptEvent>(
        (event, emit) => _handleLoginAttemptEvent(event, emit));
  }

  Future<void> _handleLoginAttemptEvent(
      LoginAttemptEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final Either<bool, Failure> status =
        await firebaseAuthenticationService.signInWithEmailAndPassword(
            email: event.email, password: event.password);
    status.fold((l) => emit(LoginSuccessState()),
        (r) => emit(LoginFailedState(message: r.message)));
  }
}
