import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/chat/models/message_model.dart';
import 'package:the_fair_players_administration/modules/chat/models/chat_room_model.dart';
import 'package:the_fair_players_administration/modules/chat/repositories/chat_repository.dart';

import '../../core/repositories/delete_repository.dart';
import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class ClubRepository implements ChatRepository, DeleteRepository {
  Future<DataSnapshot> getAllClubsSnapshot(String? key) {
    DatabaseReference clubReference =
        FirebaseDatabaseService().getReference("Clubs");
    if (key != null) {
      return clubReference
          .endBefore(null, key: key)
          .limitToLast(AppConstants.lazyLoadLength)
          .get();
    } else {
      return clubReference.limitToLast(AppConstants.lazyLoadLength).get();
    }
  }

  Future<bool> ifClubChatExist({required String clubId}) async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Chat")
        .child(clubId)
        .child("MessageList")
        .child(clubId)
        .get();
    return snapshot.exists;
  }

  @override
  Future<DataSnapshot> entitySnapshotFunction(String? key) =>
      getAllClubsSnapshot(key);

  @override
  String getAdminIdFromSnapshot({required DataSnapshot snapshot}) {
    // return snapshot
    //     .child("Members")
    //     .children
    //     .where((element) =>
    //         (element.value as Map<String, dynamic>)["status"] == "Admin")
    //     .first
    //     .child("uid")
    //     .value as String?;
    return snapshot.key as String;
  }

  Future<ChatRoomModel> getChatRoomByUid({required String uid}) async {
    DataSnapshot snapshot =
        await FirebaseDatabaseService().getReference("Clubs").child(uid).get();
    return ChatRoomModel.fromClubJson(
        snapshot.value as Map<String, dynamic>, uid);
  }

  @override
  Future<String> getRoomAdminId({required String teamId}) async =>
      Future.value(teamId);

  @override
  Future<ChatRoomModel> getSingleChatRoom({required String uid}) =>
      getChatRoomByUid(uid: uid);

  @override
  Future<bool> roomExistChecker(
          {required String uid, required String teamId}) =>
      ifClubChatExist(clubId: uid);

  @override
  Future<bool> sendAdminMessage(
      {required MessageModel messageModel, required String teamId}) async {
    bool flag = false;
    log(teamId, name: "sendAdminMessage");
    DatabaseReference teamMessageReference = FirebaseDatabaseService()
        .getReference("Chat")
        .child(teamId)
        .child("MessageList")
        .child(teamId);
    await teamMessageReference
        .push()
        .set(messageModel.toJson())
        .whenComplete(() {
      flag = true;
    });
    return flag;
  }

  @override
  Stream<DatabaseEvent> messageListStream(
      {required String uid, required String teamId}) {
    DatabaseReference teamMessageReference = FirebaseDatabaseService()
        .getReference("Chat")
        .child(uid)
        .child("MessageList")
        .child(teamId);
    return teamMessageReference.onValue;
  }

  @override
  Future<bool> deleteModel(String? key) async {
    try {
      await FirebaseDatabaseService()
          .getReference("Clubs")
          .child(key!)
          .remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}
