part of 'toggle_side_bar_bloc.dart';

abstract class ToggleSideBarState extends Equatable {
  const ToggleSideBarState();

  @override
  List<Object> get props => [];
}

class ToggleSideBarInitial extends ToggleSideBarState {}

class ToggleSideBarLoadingState extends ToggleSideBarState {}

class SideBarOnState extends ToggleSideBarState {}

class SideBarOffState extends ToggleSideBarState {}
