import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_fair_players_administration/modules/chat/models/chat_room_model.dart';

part 'search_chat_room_event.dart';
part 'search_chat_room_state.dart';

class SearchChatRoomBloc
    extends Bloc<SearchChatRoomEvent, SearchChatRoomState> {
  SearchChatRoomBloc() : super(SearchChatRoomInitial()) {
    on<SearchChatRoomEvent>((event, emit) {});
    on<SearchChatRoomAttempt>(
        (event, emit) => _handleSearchChatRoom(event, emit));
  }

  _handleSearchChatRoom(
      SearchChatRoomAttempt event, Emitter<SearchChatRoomState> emit) {
    try {
      emit(SeachChatRoomLoadingState());
      List<ChatRoomModel> searchedChatRooms = event.chatRooms
          .where((element) => element.name!
              .replaceAll(" ", "")
              .toLowerCase()
              .contains(event.searchKeyword.replaceAll(" ", "").toLowerCase()))
          .toList();
      emit(SearchChatRoomSuccessState(chatRooms: searchedChatRooms));
    } catch (e) {
      emit(SearchChatRoomSuccessState(chatRooms: event.chatRooms));
    }
  }
}
