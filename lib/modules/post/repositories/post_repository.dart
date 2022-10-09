import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/core/routes/app_routes.dart';

import '../../core/repositories/delete_repository.dart';
import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class PostRepostitory implements DeleteRepository {
  Future<DataSnapshot> getAllPostSnapshot({required String uid,required PostType postType, String? key}) {
    String refName;
    switch (postType) {
      case PostType.user:
        refName = "Posts";
        break;
      case PostType.team:
        refName = "TeamsPosts";
        break;
      case PostType.club:
        refName = "ClubPosts";
        break;
      case PostType.competition:
        refName = "CompetitionPosts";
        break;
    }
    DatabaseReference postReference =
        FirebaseDatabaseService().getReference(refName).child(uid);
    if (key != null) {
      return postReference
          .endBefore(null, key: key)
          .limitToLast(AppConstants.lazyLoadLength)
          .get();
    } else {
      return postReference.limitToLast(AppConstants.lazyLoadLength).get();
    }
  }

  /*Future<DataSnapshot> getAllTeamPostSnapshot({required String uid, String? key}) {
    DatabaseReference postReference =
        FirebaseDatabaseService().getReference("TeamsPosts").child(uid);
    if (key != null) {
      return postReference
          .endBefore(null, key: key)
          .limitToLast(AppConstants.lazyLoadLength)
          .get();
    } else {
      return postReference.limitToLast(AppConstants.lazyLoadLength).get();
    }
  }*/

  @override
  Future<bool> deleteModel({String? key, String? extraKey, PostType? postType}) async {
    try {
      log("here");

      String refName;

      switch (postType) {
        case PostType.user:
          refName = "Posts";
          break;
        case PostType.team:
          refName = "TeamsPosts";
          break;
        case PostType.club:
          refName = "ClubPosts";
          break;
        case PostType.competition:
          refName = "CompetitionPosts";
          break;
        default:
          refName = "Posts";
          break;
      }

      await FirebaseDatabaseService()
          .getReference(refName)
          .child(extraKey!)
          .child(key!)
          .remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}
