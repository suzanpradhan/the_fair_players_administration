part of 'get_chat_rooms_bloc.dart';

abstract class GetChatRoomsEvent extends Equatable {
  const GetChatRoomsEvent();

  @override
  List<Object?> get props => [];
}

class GetChatRoomsFirstAttempt extends GetChatRoomsEvent {
  final String? uid;
  const GetChatRoomsFirstAttempt({this.uid});

  @override
  List<Object?> get props => [uid];
}

class GetChatRoomsAttempt extends GetChatRoomsEvent {}

class SelectChatRoomAttempt extends GetChatRoomsEvent {
  final String uid;

  const SelectChatRoomAttempt({required this.uid});

  @override
  List<Object?> get props => [uid];
}
