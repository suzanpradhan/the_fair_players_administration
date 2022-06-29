part of 'room_message_list_bloc.dart';

abstract class RoomMessageListState extends Equatable {
  const RoomMessageListState();

  @override
  List<Object> get props => [];
}

class RoomMessageListInitial extends RoomMessageListState {}

class GetRoomMessageListLoadingState extends RoomMessageListState {}

class MessageListState extends RoomMessageListState {
  final List<MessageModel> listOfMessages;
  const MessageListState({required this.listOfMessages});

  @override
  List<Object> get props => [listOfMessages];
}
