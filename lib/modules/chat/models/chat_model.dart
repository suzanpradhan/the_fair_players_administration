class ChatModel {
  final String time;
  final String message;
  final bool isMine;
  final String? profileImage;

  const ChatModel({
    required this.time,
    required this.message,
    required this.isMine,
    this.profileImage,
  });
}

const List<ChatModel> listOfChatsMessage = [
  ChatModel(
      time: "Today 5:40 pm",
      message: "Let me know when you complete.",
      isMine: true),
  ChatModel(
      time: "Today 5:39 pm",
      message: "Thanks, I will do that than",
      isMine: false),
  ChatModel(
      time: "Today 5:33 pm",
      message: "Sure. I will share it by tonight.",
      isMine: true),
  ChatModel(
      time: "Today 5:32 pm",
      message:
          "Hey there,Please provide the necessary data so that I will start devel-opment.",
      isMine: false)
];
