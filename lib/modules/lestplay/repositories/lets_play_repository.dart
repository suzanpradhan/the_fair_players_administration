import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/chat/repositories/chat_repository.dart';
import 'package:the_fair_players_administration/modules/core/repositories/delete_repository.dart';

import '../../chat/models/chat_room_model.dart';
import '../../chat/models/message_model.dart';
import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class LetsPlayRepository implements ChatRepository, DeleteRepository {
  Future<DataSnapshot> getAllLetsPlaySnapshot(String? key) {
    DatabaseReference letsPlayReference =
        FirebaseDatabaseService().getReference("LetsPlay");
    if (key != null) {
      return letsPlayReference
          .endBefore(null, key: key)
          .limitToLast(AppConstants.lazyLoadLength)
          .get();
    } else {
      return letsPlayReference.limitToLast(AppConstants.lazyLoadLength).get();
    }
  }

  Future<bool> ifLetsPlayChatExist({required String competitionId}) async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Chat")
        .child(competitionId)
        .child("MessageList")
        .child(competitionId)
        .get();
    return snapshot.exists;
  }

  Future<ChatRoomModel> getChatRoomByUid({required String uid}) async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("LetsPlay")
        .child(uid)
        .get();
    return ChatRoomModel.fromLetsPlayJson(
        snapshot.value as Map<String, dynamic>, uid);
  }

  @override
  Future<DataSnapshot> entitySnapshotFunction(String? key) async =>
      getAllLetsPlaySnapshot(key);

  @override
  String? getAdminIdFromSnapshot({required DataSnapshot snapshot}) =>
      snapshot.key as String;

  @override
  Future<String> getRoomAdminId({required String teamId}) async =>
      Future.value(teamId);

  @override
  Future<ChatRoomModel> getSingleChatRoom({required String uid}) async =>
      getChatRoomByUid(uid: uid);

  @override
  Stream<DatabaseEvent> messageListStream(
      {required String uid, required String teamId}) {
    DatabaseReference roomMessageReference = FirebaseDatabaseService()
        .getReference("Chat")
        .child(uid)
        .child("MessageList")
        .child(teamId);
    return roomMessageReference.onValue;
  }

  @override
  Future<bool> roomExistChecker(
          {required String uid, required String teamId}) async =>
      ifLetsPlayChatExist(competitionId: uid);

  @override
  Future<bool> sendAdminMessage(
      {required MessageModel messageModel, required String teamId}) async {
    bool flag = false;
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
  Future<bool> deleteModel(String? key) async {
    try {
      await FirebaseDatabaseService()
          .getReference("LetsPlay")
          .child(key!)
          .remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}
