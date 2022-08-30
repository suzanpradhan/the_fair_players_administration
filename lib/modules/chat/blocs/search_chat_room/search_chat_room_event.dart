part of 'search_chat_room_bloc.dart';

abstract class SearchChatRoomEvent extends Equatable {
  const SearchChatRoomEvent();

  @override
  List<Object?> get props => [];
}

class SearchChatRoomAttempt extends SearchChatRoomEvent {
  final String searchKeyword;
  final ChatRoomModel? selectedRoom;
  final List<ChatRoomModel> chatRooms;
  const SearchChatRoomAttempt(
      {required this.chatRooms,
      this.selectedRoom,
      required this.searchKeyword});

  @override
  List<Object?> get props => [chatRooms, selectedRoom, searchKeyword];
}
