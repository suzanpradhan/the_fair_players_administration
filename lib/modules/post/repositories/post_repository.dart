import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import '../../core/repositories/delete_repository.dart';
import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class PostRepostitory implements DeleteRepository {
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

  @override
  Future<bool> deleteModel({String? key, String? extraKey}) async {
    try {
      log("here");
      await FirebaseDatabaseService()
          .getReference("Posts")
          .child(extraKey!)
          .child(key!)
          .remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}
