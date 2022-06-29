part of 'toggle_side_bar_bloc.dart';

abstract class ToggleSideBarEvent extends Equatable {
  const ToggleSideBarEvent();

  @override
  List<Object> get props => [];
}

class ToggleSideBarAttempt extends ToggleSideBarEvent {}
