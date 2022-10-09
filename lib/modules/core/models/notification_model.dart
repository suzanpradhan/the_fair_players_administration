class NotificationModel {
  final String token;
  final String type;
  final String senderName;
  final String senderUID;
  final String senderImage;
  final String title;
  final String message;
  final String receiverUID;
  final String receiverType;

  const NotificationModel(
      {required this.token,
      required this.type,
      required this.senderName,
      required this.senderUID,
      required this.senderImage,
      required this.title,
      required this.message,
      required this.receiverUID,
      required this.receiverType});
  Map<String, dynamic> toJsonData() => {
        'type': type,
        'senderName': senderName,
        'senderUID': senderUID,
        'senderImage': senderImage,
        'title': title,
        'message': message,
        "receiverUID": receiverUID,
        "receiverType": receiverType,
      };
}
