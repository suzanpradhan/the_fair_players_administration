import 'package:equatable/equatable.dart';

class ChatRoomModel extends Equatable {
  final String? uid;
  final String? name;
  final String? recentMessage;
  final String? messageType;
  final int? notifyCount;
  final String? chatRoomImage;
  final DateTime? dateTime;

  const ChatRoomModel({
    this.uid,
    this.name,
    this.recentMessage,
    this.messageType,
    this.dateTime,
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
        chatRoomImage: jsonMapData["chatRoomImage"],
        dateTime: (jsonMapData["time"] != null)
            ? DateTime.fromMillisecondsSinceEpoch(jsonMapData["time"].toInt())
            : null,
      );

  factory ChatRoomModel.fromClubJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      ChatRoomModel(
        uid: key,
        name: jsonMapData["clubName"],
        chatRoomImage: jsonMapData["clubImage"],
      );

  factory ChatRoomModel.fromUserProfileJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      ChatRoomModel(
        uid: key,
        name: "${jsonMapData["firstName"]} ${jsonMapData["lastName"]}",
        chatRoomImage: jsonMapData["image"],
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

  Map<String, dynamic> toJsonForAdminUserChat() => {
        "name": "Admin",
        "message": recentMessage,
        "messageType": messageType,
        "time": DateTime.now().millisecondsSinceEpoch
      };
}
