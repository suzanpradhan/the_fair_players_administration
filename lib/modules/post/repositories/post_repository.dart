import 'package:firebase_database/firebase_database.dart';

import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class PostRepostitory {
  Future<DataSnapshot> getAllPostSnapshot({required String uid, String? key}) {
    DatabaseReference postReference =
        FirebaseDatabaseService().getReference("Posts").child(uid);
    if (key != null) {
      return postReference
          .endBefore(null, key: key)
          .limitToLast(AppConstants.lazyLoadLength)
          .get();
    } else {
      return postReference.limitToLast(AppConstants.lazyLoadLength).get();
    }
  }
}
