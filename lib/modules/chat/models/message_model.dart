import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String? message;
  final String? messageType;
  final String? uid;
  final String? userImage;
  final String? userID;
  final String? userName;
  final DateTime? dateTime;

  const MessageModel(
      {this.message,
      this.messageType,
      this.uid,
      this.dateTime,
      this.userID,
      this.userImage,
      this.userName});

  @override
  List<Object?> get props => [uid];

  factory MessageModel.fromJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      MessageModel(
          uid: key,
          message: jsonMapData["message"],
          messageType: jsonMapData["messageType"],
          userImage: (jsonMapData["userImage"] != null &&
                  jsonMapData["userImage"] != "null")
              ? jsonMapData["userImage"]
              : null,
          userName: jsonMapData["userName"],
          dateTime: (jsonMapData["time"] != null)
              ? DateTime.fromMillisecondsSinceEpoch(jsonMapData["time"].toInt())
              : null,
          userID: jsonMapData["userID"]);

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "message": message,
        "messageType": messageType,
        "userName": userName,
        "userImage": userImage,
        "time": DateTime.now().millisecondsSinceEpoch
      };

  Map<String, dynamic> toRecentMessageJson() => {
        "message": message,
        "messageType": messageType,
        "time": DateTime.now().millisecondsSinceEpoch
      };

  copyWith({
    String? message,
    String? messageType,
    String? userImage,
    String? userID,
    String? userName,
  }) {
    return MessageModel(
        message: message ?? this.message,
        messageType: messageType ?? this.messageType,
        userID: userID ?? this.userID,
        userImage: userImage ?? this.userImage,
        userName: userImage ?? this.userImage);
  }
}
