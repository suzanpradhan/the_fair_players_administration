import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/authentication/services/firebase_authentication_service.dart';
import 'package:the_fair_players_administration/modules/chat/models/message_model.dart';
import 'package:the_fair_players_administration/modules/chat/models/chat_room_model.dart';
import 'package:the_fair_players_administration/modules/core/models/notification_model.dart';
import 'package:the_fair_players_administration/modules/core/repositories/delete_repository.dart';
import 'package:the_fair_players_administration/modules/core/services/push_notification_sender.dart';

import '../../chat/repositories/chat_repository.dart';
import '../../core/services/firebase_database_service.dart';
import '../../core/theme/app_constants.dart';

class UserRepository implements ChatRepository, DeleteRepository {
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

  @override
  Future<bool> deleteModel({String? key, String? extraKey}) async {
    try {
      await FirebaseDatabaseService()
          .getReference("Users")
          .child("Profile")
          .child(key!)
          .remove();
      await FirebaseDatabaseService().getReference("Chat").child(key).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteMessage(String uid, String teamId, String key) async {
    await FirebaseDatabaseService()
        .getReference("Chat")
        .child(uid)
        .child("MessageList")
        .child(teamId)
        .child(key)
        .remove();
  }

  @override
  Future<DataSnapshot> entitySnapshotFunction(String? key) async {
    DatabaseReference competitionReference =
        FirebaseDatabaseService().getReference("Users").child("Profile");
    return competitionReference.get();
  }

  @override
  String? getAdminIdFromSnapshot({required DataSnapshot snapshot}) {
    return "admin";
  }

  @override
  Future<String> getRoomAdminId({required String teamId}) =>
      Future.value(teamId);

  @override
  Future<ChatRoomModel> getSingleChatRoom({required String uid}) async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Users")
        .child("Profile")
        .child(uid)
        .get();
    return ChatRoomModel.fromUserProfileJson(
        snapshot.value as Map<String, dynamic>, uid);
  }

  @override
  Stream<DatabaseEvent> messageListStream(
      {required String uid, required String teamId}) {
    DatabaseReference teamMessageReference = FirebaseDatabaseService()
        .getReference("Chat")
        .child(uid)
        .child("MessageList")
        .child("admin");
    return teamMessageReference.onValue;
  }

  @override
  Future<bool> roomExistChecker(
      {required String uid, required String teamId}) async {
    return true;
  }

  Future<bool> ifAdminUserChatExist({required String id}) async {
    DataSnapshot snapshot = await FirebaseDatabaseService()
        .getReference("Chat")
        .child(id)
        .child("MessageList")
        .child("admin")
        .get();
    return snapshot.exists;
  }

  Future<bool> sendAdminBulkMessage(
      {required MessageModel messageModel}) async {
    try {
      DataSnapshot entitySnapshot = await entitySnapshotFunction(null);
      for (DataSnapshot element in entitySnapshot.children) {
        await sendAdminMessage(
            messageModel: messageModel, teamId: element.key!);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> sendAdminMessage(
      {required MessageModel messageModel, required String teamId}) async {
    bool flag = false;
    log(teamId, name: "sendAdminMessage");
    ChatRoomModel chatRoomModel = ChatRoomModel(
      recentMessage: messageModel.message,
      messageType: messageModel.messageType,
    );
    DatabaseReference userChatReference = FirebaseDatabaseService()
        .getReference("Chat")
        .child(teamId)
        .child("ChatList")
        .child("admin");
    await userChatReference.set(chatRoomModel.toJsonForAdminUserChat());
    DatabaseReference userMessageReference = FirebaseDatabaseService()
        .getReference("Chat")
        .child(teamId)
        .child("MessageList")
        .child("admin");
    await userMessageReference
        .push()
        .set(messageModel.toJson())
        .whenComplete(() {
      flag = true;
    });
    if ((await entitySnapshotFunction(null))
        .child(teamId)
        .child("token")
        .exists) {
      PushNotificationSender.send(NotificationModel(
          token: (await entitySnapshotFunction(null))
              .child(teamId)
              .child("token")
              .value as String,
          type: "Message",
          senderName: "Admin",
          senderUID: "admin",
          senderImage: "",
          title: "Message from Admin",
          message: messageModel.message ?? "",
          receiverUID: teamId,
          receiverType: "user"));
    }

    return flag;
  }
}
