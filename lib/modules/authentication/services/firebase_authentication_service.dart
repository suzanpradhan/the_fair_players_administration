import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_fair_players_administration/modules/core/error_handling/failure.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuthenticationService();

  Stream<User?> get onAuthStateChanged {
    return _auth.authStateChanges();
  }

  bool get isAuthenticated {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  User get getUser {
    return _auth.currentUser!;
  }

  Future<Either<bool, Failure>> signInWithEmailAndPassword(
      {required email, required password}) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return const Left(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        return const Right(Failure(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        return const Right(
            Failure(message: 'Wrong password provided for that user.'));
      }
      return const Right(Failure(message: 'Error signing in.'));
    }
  }

  Future<void> get signOut async {
    log('Sign Out');
    await _auth.signOut();
  }
}
