part of 'chat_navigation_bloc.dart';

class ChatNavigationState extends Equatable {
  final bool isChatRoom;
  const ChatNavigationState({required this.isChatRoom});

  @override
  List<Object> get props => [isChatRoom];
}
