import 'package:firebase_database/firebase_database.dart';

import '../models/chat_room_model.dart';
import '../models/message_model.dart';

abstract class ChatRepository {
  Future<DataSnapshot> entitySnapshotFunction(String? key);
  Future<ChatRoomModel> getSingleChatRoom({required String uid});
  String? getAdminIdFromSnapshot({required DataSnapshot snapshot});
  Future<bool> roomExistChecker({required String uid, required String teamId});
  Future<String> getRoomAdminId({required String teamId});
  Future<bool> sendAdminMessage(
      {required MessageModel messageModel, required String teamId});
  Stream<DatabaseEvent> messageListStream(
      {required String uid, required String teamId});
  Future<void> deleteMessage(String uid, String teamId, String key);
}
