part of 'room_message_list_bloc.dart';

abstract class RoomMessageListEvent extends Equatable {
  const RoomMessageListEvent();

  @override
  List<Object> get props => [];
}

class GetRoomMessageList extends RoomMessageListEvent {
  final String roomUid;
  const GetRoomMessageList({required this.roomUid});

  @override
  List<Object> get props => [roomUid];
}
