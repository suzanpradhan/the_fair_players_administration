import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  FirebaseDatabaseService();
  final FirebaseDatabase instance = FirebaseDatabase.instance;

  FirebaseDatabase get database => instance;

  DatabaseReference getReference(String ref) {
    return instance.ref(ref);
  }
}
