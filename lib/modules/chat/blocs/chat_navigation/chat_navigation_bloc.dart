import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_navigation_event.dart';
part 'chat_navigation_state.dart';

class ChatNavigationBloc
    extends Bloc<ChatNavigationEvent, ChatNavigationState> {
  ChatNavigationBloc() : super(const ChatNavigationState(isChatRoom: false)) {
    on<ChatNavigationEvent>((event, emit) {
      emit(const ChatNavigationState(isChatRoom: false));
    });
    on<ChatNavigationToggle>(
        (event, emit) => emit(ChatNavigationState(isChatRoom: event.value)));
  }
}
