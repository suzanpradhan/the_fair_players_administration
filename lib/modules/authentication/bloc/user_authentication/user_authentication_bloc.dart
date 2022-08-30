import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_fair_players_administration/modules/authentication/services/firebase_authentication_service.dart';

part 'user_authentication_event.dart';
part 'user_authentication_state.dart';

class UserAuthenticationBloc
    extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  FirebaseAuthenticationService firebaseAuthenticationService;
  UserAuthenticationBloc(
    this.firebaseAuthenticationService,
  ) : super(const UserAuthenticationState(user: null)) {
    on<UserAuthenticationEvent>(
      (event, emit) async {
        await emit.forEach(firebaseAuthenticationService.onAuthStateChanged,
            onData: (User? user) => UserAuthenticationState(user: user));
      },
    );
  }
}
