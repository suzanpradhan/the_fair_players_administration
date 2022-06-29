part of 'chat_navigation_bloc.dart';

abstract class ChatNavigationEvent extends Equatable {
  const ChatNavigationEvent();

  @override
  List<Object> get props => [];
}

class ChatNavigationToggle extends ChatNavigationEvent {
  final bool value;
  const ChatNavigationToggle({required this.value});

  @override
  List<Object> get props => [value];
}
