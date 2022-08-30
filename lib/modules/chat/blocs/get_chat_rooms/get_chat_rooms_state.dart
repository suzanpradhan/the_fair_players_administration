part of 'get_chat_rooms_bloc.dart';

abstract class GetChatRoomsState extends Equatable {
  const GetChatRoomsState();

  @override
  List<Object?> get props => [];
}

class GetChatRoomsInitial extends GetChatRoomsState {}

class GetChatRoomsLoadingState extends GetChatRoomsState {}

class GotChatRoomsSuccessState extends GetChatRoomsState {
  final List<ChatRoomModel> listOfChatRooms;
  final bool hasMore;
  final ChatRoomModel? selectedChatRoom;
  const GotChatRoomsSuccessState(
      {required this.listOfChatRooms,
      required this.hasMore,
      this.selectedChatRoom});

  GotChatRoomsSuccessState addListOfChatRooms(
      {required List<ChatRoomModel> listOfChatRooms, bool? hasMore}) {
    if (listOfChatRooms.isNotEmpty) {
      this.listOfChatRooms.addAll(listOfChatRooms);
    }

    this.listOfChatRooms.toSet();
    return GotChatRoomsSuccessState(
        listOfChatRooms: this.listOfChatRooms,
        hasMore: listOfChatRooms.isNotEmpty,
        selectedChatRoom: selectedChatRoom);
  }

  GotChatRoomsSuccessState selectChatRoom({required String uid}) {
    if (listOfChatRooms.where((element) => element.uid == uid).isNotEmpty) {
      return GotChatRoomsSuccessState(
          listOfChatRooms: listOfChatRooms,
          hasMore: listOfChatRooms.isNotEmpty,
          selectedChatRoom:
              listOfChatRooms.where((element) => element.uid == uid).first);
    }
    return GotChatRoomsSuccessState(
        listOfChatRooms: listOfChatRooms,
        hasMore: listOfChatRooms.isNotEmpty,
        selectedChatRoom: selectedChatRoom);
  }

  @override
  List<Object?> get props => [listOfChatRooms, hasMore, selectedChatRoom];
}

class GetChatRoomsFailedState extends GetChatRoomsState {
  final String errorMessage;
  const GetChatRoomsFailedState({required this.errorMessage});
}
