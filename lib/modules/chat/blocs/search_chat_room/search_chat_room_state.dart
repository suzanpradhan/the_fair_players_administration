part of 'search_chat_room_bloc.dart';

abstract class SearchChatRoomState {
  const SearchChatRoomState();
}

class SearchChatRoomInitial extends SearchChatRoomState {}

class SeachChatRoomLoadingState extends SearchChatRoomState {}

class SearchChatRoomSuccessState extends SearchChatRoomState {
  final List<ChatRoomModel> chatRooms;
  const SearchChatRoomSuccessState({required this.chatRooms});
}
