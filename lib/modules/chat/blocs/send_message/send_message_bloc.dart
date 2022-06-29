import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_fair_players_administration/modules/chat/models/message_model.dart';
import 'package:the_fair_players_administration/modules/chat/repositories/chat_repository.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final ChatRepository chatRepository;
  SendMessageBloc({required this.chatRepository})
      : super(SendMessageInitial()) {
    on<SendMessageEvent>((event, emit) {});
    on<SendAdminMessageAttempt>(
        (event, emit) => _handleSendAdminMessage(event, emit));
  }

  _handleSendAdminMessage(
      SendAdminMessageAttempt event, Emitter<SendMessageState> emit) async {
    try {
      bool status = await chatRepository.sendAdminMessage(
          messageModel: event.messageModel, teamId: event.teamId);
      if (status) {
        emit(AdminMessageSent());
      } else {
        emit(const AdminMessageSendFailed(message: "Message send failed!"));
      }
    } catch (e) {
      emit(const AdminMessageSendFailed(message: "Message send failed!"));
    }
  }
}
