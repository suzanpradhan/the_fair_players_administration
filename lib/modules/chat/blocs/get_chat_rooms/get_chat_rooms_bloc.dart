import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/chat/repositories/chat_repository.dart';

import '../../models/chat_room_model.dart';

part 'get_chat_rooms_event.dart';
part 'get_chat_rooms_state.dart';

class GetChatRoomsBloc extends Bloc<GetChatRoomsEvent, GetChatRoomsState> {
  final ChatRepository chatRepository;
  String? lastDocumentKey;
  GetChatRoomsBloc({required this.chatRepository})
      : super(GetChatRoomsInitial()) {
    on<GetChatRoomsEvent>((event, emit) {});
    on<GetChatRoomsFirstAttempt>((event, emit) async {
      emit(GetChatRoomsLoadingState());

      List<ChatRoomModel> listOfChatRooms = await getListOfChatRooms();
      if (event.uid != null) {
        ChatRoomModel selectedChatRoom =
            await chatRepository.getSingleChatRoom(uid: event.uid!);
        listOfChatRooms.add(selectedChatRoom);
        emit(GotChatRoomsSuccessState(
            listOfChatRooms: listOfChatRooms.reversed.toSet().toList(),
            hasMore: true,
            selectedChatRoom: selectedChatRoom));
      } else {
        emit(GotChatRoomsSuccessState(
            listOfChatRooms: listOfChatRooms.reversed.toSet().toList(),
            hasMore: true));
      }
    });
    on<GetChatRoomsAttempt>((event, emit) async {
      List<ChatRoomModel> listOfClubs = await getListOfChatRooms();
      if (state is GotChatRoomsSuccessState) {
        emit((state as GotChatRoomsSuccessState).addListOfChatRooms(
            listOfChatRooms: listOfClubs.reversed.toSet().toList(),
            hasMore: listOfClubs.isNotEmpty));
      } else {
        emit(GotChatRoomsSuccessState(
            listOfChatRooms: listOfClubs.reversed.toSet().toList(),
            hasMore: true));
      }
    });
    on<SelectChatRoomAttempt>(
        (event, emit) => _handleSelectChatRoom(event, emit));
  }

  Future<List<ChatRoomModel>> getListOfChatRooms() async {
    DataSnapshot entitySnapshot =
        await chatRepository.entitySnapshotFunction(lastDocumentKey);

    List<ChatRoomModel> chatRoomsModel = [];

    for (DataSnapshot element in entitySnapshot.children) {
      bool isRoomExist = await chatRepository.roomExistChecker(
          uid: chatRepository.getAdminIdFromSnapshot(snapshot: element)!,
          teamId: element.key!);
      if (isRoomExist) {
        chatRoomsModel
            .add(await chatRepository.getSingleChatRoom(uid: element.key!));
      }
    }
    lastDocumentKey = entitySnapshot.children.first.key;
    return chatRoomsModel;
  }

  _handleSelectChatRoom(
      SelectChatRoomAttempt event, Emitter<GetChatRoomsState> emit) async {
    if (state is GotChatRoomsSuccessState) {
      emit((state as GotChatRoomsSuccessState).selectChatRoom(uid: event.uid));
    } else {
      emit(const GotChatRoomsSuccessState(listOfChatRooms: [], hasMore: false));
    }
  }
}
