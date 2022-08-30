import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/chat_repository.dart';

part 'delete_message_event.dart';
part 'delete_message_state.dart';

class DeleteMessageBloc extends Bloc<DeleteMessageEvent, DeleteMessageState> {
  final ChatRepository chatRepository;
  DeleteMessageBloc({required this.chatRepository})
      : super(DeleteMessageInitial()) {
    on<DeleteMessageEvent>((event, emit) {});
    on<DeleteMessageAttempt>((event, emit) async {
      log("here");
      String adminId =
          await chatRepository.getRoomAdminId(teamId: event.roomUid);
      log("here");
      chatRepository.deleteMessage(event.roomUid, adminId, event.messageId);
      log("here");
      emit(DeleteMessageSuccesState());
    });
  }
}
