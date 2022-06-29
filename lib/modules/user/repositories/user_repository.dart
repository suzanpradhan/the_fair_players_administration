import 'package:firebase_database/firebase_database.dart';

import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class UserRepository {
  Future<DataSnapshot> getUserSnapshot(String? key, String? searchValue) {
    DatabaseReference userReference =
        FirebaseDatabaseService().getReference("Users").child("Profile");
    if (key != null) {
      if (searchValue != null) {
        return FirebaseDatabaseService()
            .getReference("Users")
            .child("Profile")
            .orderByChild("firstName")
            .startAt(searchValue)
            .endAt("$searchValue\u{F8FF}")
            .once()
            .then((value) {
          return value.snapshot;
        });
      } else {
        return userReference
            .endBefore(null, key: key)
            .limitToLast(AppConstants.lazyLoadLength)
            .get();
      }
    } else {
      if (searchValue != null) {
        return FirebaseDatabaseService()
            .getReference("Users")
            .child("Profile")
            .orderByChild("firstName")
            .startAt(searchValue)
            .endAt("$searchValue\uf8ff")
            .once()
            .then((value) {
          return value.snapshot;
        });
      } else {
        return userReference.limitToLast(AppConstants.lazyLoadLength).get();
      }
    }
  }
}
