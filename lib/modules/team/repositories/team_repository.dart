import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/chat/models/chat_room_model.dart';
import 'package:the_fair_players_administration/modules/chat/models/message_model.dart';
import 'package:the_fair_players_administration/modules/chat/repositories/chat_repository.dart';
import 'package:the_fair_players_administration/modules/core/repositories/delete_repository.dart';

import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class TeamRepository implements ChatRepository, DeleteRepository {
  Future<DataSnapshot> getAllTeamsSnapshot(String? key) {
    DatabaseReference teamReference =
        FirebaseDatabaseService().getReference("Teams");
    if (key != null) {
      return teamReference
          .endBefore(null, key: key)
          .limitToLast(AppConstants.lazyLoadLength)
          .get();
    } else {
      return teamReference.limitToLast(AppConstants.lazyLoadLength).get();
    }
  }

  Future<DataSnapshot> getAllTeamsChat(String? key) {
    DatabaseReference teamReference =
        FirebaseDatabaseService().getReference("Chat");
    if (key != null) {
      return teamReference
          .endBefore(null, key: key)
          .limitToLast(AppConstants.lazyLoadLength)
          .get();
    } else {
      return teamReference.limitToLast(AppConstants.lazyLoadLength).get();
    }
  }

  Future<bool> ifTeamChatExist({required String uid}) async {
    String teamAdminId = await getRoomAdminId(teamId: uid);
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Chat")
        .child(teamAdminId)
        .child("MessageList")
        .child(uid)
        .get();
    return snapshot.exists;
  }

  Future<bool> isTeamChatRoomExist(
      {required String uid, required String teamId}) async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Chat")
        .child(uid)
        .child("ChatList")
        .child(teamId)
        .get();
    return snapshot.exists;
  }

  Future<ChatRoomModel> getChatRoomByUid({required String uid}) async {
    String teamAdminId = await getRoomAdminId(teamId: uid);
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Chat")
        .child(teamAdminId)
        .child("ChatList")
        .child(uid)
        .get();
    log(snapshot.value.toString());
    return ChatRoomModel.fromJson(snapshot.value as Map<String, dynamic>, uid);
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
  Future<bool> sendAdminMessage(
      {required MessageModel messageModel, required String teamId}) async {
    bool flag = false;
    String teamAdminId = await getRoomAdminId(teamId: teamId);
    log(teamAdminId, name: "sendAdminMessage");
    log(teamId, name: "sendAdminMessage");
    DatabaseReference teamMembersReference = FirebaseDatabaseService()
        .getReference("Teams")
        .child(teamId)
        .child("Members");
    DatabaseReference teamChatReference = FirebaseDatabaseService()
        .getReference("Chat")
        .child(teamAdminId)
        .child("ChatList")
        .child(teamId);
    teamMembersReference.get().then((value) async {
      for (var element in value.children) {
        await FirebaseDatabaseService()
            .getReference("Chat")
            .child(element.child("uid").value! as String)
            .child("MessageList")
            .child(teamId)
            .push()
            .set(messageModel.toJson())
            .whenComplete(() {});
      }
    });
    await teamChatReference.update(messageModel.toRecentMessageJson());
    flag = true;
    return flag;
  }

  @override
  Future<DataSnapshot> entitySnapshotFunction(String? key) {
    DatabaseReference teamReference =
        FirebaseDatabaseService().getReference("Teams");
    return teamReference.get();
  }

  @override
  String? getAdminIdFromSnapshot({required DataSnapshot snapshot}) {
    return snapshot.child("adminUID").value as String?;
  }

  @override
  Future<ChatRoomModel> getSingleChatRoom({required String uid}) =>
      getChatRoomByUid(uid: uid);

  @override
  Future<bool> roomExistChecker(
          {required String uid, required String teamId}) =>
      isTeamChatRoomExist(uid: uid, teamId: teamId);

  @override
  Future<String> getRoomAdminId({required String teamId}) async {
    DataSnapshot teamSnapshot = await FirebaseDatabaseService()
        .getReference("Teams")
        .child(teamId)
        .get();
    log(teamSnapshot.key.toString(), name: "teamSnapshot");
    return teamSnapshot.child("adminUID").value as String;
  }

  @override
  Future<bool> deleteModel({String? key, String? extraKey}) async {
    try {
      print("selected key is $key");
      DatabaseReference teamMembersReference = FirebaseDatabaseService()
          .getReference("Teams")
          .child(key!)
          .child("Members");
      teamMembersReference.get().then((value) async {
        for (var element in value.children) {
          await FirebaseDatabaseService()
              .getReference("Chat")
              .child(element.child("uid").value! as String)
              .child("ChatList")
              .child(key)
              .remove();
          await FirebaseDatabaseService()
              .getReference("Chat")
              .child(element.child("uid").value! as String)
              .child("MessageList")
              .child(key)
              .remove();
        }
      });
      await FirebaseDatabaseService().getReference("Teams").child(key).remove();
      await FirebaseDatabaseService()
          .getReference("TeamsPostComments")
          .child(key)
          .remove();
      await FirebaseDatabaseService()
          .getReference("TeamsPosts")
          .child(key)
          .remove();
      print("112233, its done, deleted");
      return true;
    } catch (e) {
      print("112233, error occured: $e");
      return false;
    }
  }

  @override
  Future<void> deleteMessage(String uid, String teamId, String key) async {
    DatabaseReference teamMembersReference = FirebaseDatabaseService()
        .getReference("Teams")
        .child(uid)
        .child("Members");
    teamMembersReference.get().then((value) async {
      for (var element in value.children) {
        await FirebaseDatabaseService()
            .getReference("Chat")
            .child(element.child("uid").value! as String)
            .child("MessageList")
            .child(uid)
            .child(key)
            .remove();
      }
    });
  }
}
