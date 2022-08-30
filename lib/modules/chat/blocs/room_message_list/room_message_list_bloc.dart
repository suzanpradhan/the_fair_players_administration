import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/chat/models/message_model.dart';
import 'package:the_fair_players_administration/modules/chat/repositories/chat_repository.dart';

part 'room_message_list_event.dart';
part 'room_message_list_state.dart';

class RoomMessageListBloc
    extends Bloc<RoomMessageListEvent, RoomMessageListState> {
  final ChatRepository chatRepository;
  RoomMessageListBloc({required this.chatRepository})
      : super(RoomMessageListInitial()) {
    on<RoomMessageListEvent>((event, emit) {});
    on<GetRoomMessageList>((event, emit) async {
      String adminId =
          await chatRepository.getRoomAdminId(teamId: event.roomUid);
      await emit.onEach<DatabaseEvent>(
          chatRepository.messageListStream(uid: adminId, teamId: event.roomUid),
          onData: (data) {
        List<MessageModel> listOfMessages = data.snapshot.children
            .map((message) => MessageModel.fromJson(
                message.value as Map<String, dynamic>, message.key))
            .toList()
            .reversed
            .toList();
        emit(MessageListState(listOfMessages: listOfMessages));
      });
    }, transformer: restartable());
  }
}
