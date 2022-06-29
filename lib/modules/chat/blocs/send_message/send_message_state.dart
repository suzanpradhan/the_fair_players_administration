part of 'send_message_bloc.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class SendMessageInitial extends SendMessageState {}

class AdminMessageSending extends SendMessageInitial {}

class AdminMessageSent extends SendMessageState {}

class AdminMessageSendFailed extends SendMessageState {
  final String message;
  const AdminMessageSendFailed({required this.message});

  @override
  List<Object> get props => [message];
}
