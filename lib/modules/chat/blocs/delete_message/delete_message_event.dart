part of 'delete_message_bloc.dart';

abstract class DeleteMessageEvent extends Equatable {
  const DeleteMessageEvent();

  @override
  List<Object> get props => [];
}

class DeleteMessageAttempt extends DeleteMessageEvent {
  final String roomUid;
  final String messageId;
  const DeleteMessageAttempt({required this.roomUid, required this.messageId});

  @override
  List<Object> get props => [roomUid, messageId];
}
