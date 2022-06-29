import 'package:equatable/equatable.dart';

class ChatRoomModel extends Equatable {
  final String? uid;
  final String? name;
  final String? recentMessage;
  final String? messageType;
  final int? notifyCount;
  final String? chatRoomImage;

  const ChatRoomModel({
    this.uid,
    this.name,
    this.recentMessage,
    this.messageType,
    this.notifyCount,
    this.chatRoomImage,
  });

  @override
  List<Object?> get props => [uid];

  factory ChatRoomModel.fromJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      ChatRoomModel(
        uid: key,
        name: jsonMapData["name"],
        recentMessage: jsonMapData["message"],
        messageType: jsonMapData["messageType"],
        notifyCount: jsonMapData["notifyCount"],
        chatRoomImage: jsonMapData["chatRoomImage"],
      );

  factory ChatRoomModel.fromClubJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      ChatRoomModel(
        uid: key,
        name: jsonMapData["clubName"],
        chatRoomImage: jsonMapData["clubImage"],
      );

  factory ChatRoomModel.fromCompetitionJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      ChatRoomModel(
        uid: key,
        name: jsonMapData["competitionName"],
        chatRoomImage: jsonMapData["competitionImage"],
      );

  factory ChatRoomModel.fromLetsPlayJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      ChatRoomModel(uid: key, name: jsonMapData["sports"]);
}
