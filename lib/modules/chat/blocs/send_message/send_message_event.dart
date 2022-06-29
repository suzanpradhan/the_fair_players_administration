part of 'send_message_bloc.dart';

abstract class SendMessageEvent extends Equatable {
  const SendMessageEvent();

  @override
  List<Object> get props => [];
}

class SendAdminMessageAttempt extends SendMessageEvent {
  final MessageModel messageModel;
  final String teamId;
  const SendAdminMessageAttempt(
      {required this.messageModel, required this.teamId});

  @override
  List<Object> get props => [messageModel, teamId];
}
