import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_side_bar_event.dart';
part 'toggle_side_bar_state.dart';

class ToggleSideBarBloc extends Bloc<ToggleSideBarEvent, ToggleSideBarState> {
  ToggleSideBarBloc() : super(SideBarOnState()) {
    on<ToggleSideBarEvent>((event, emit) {});
    on<ToggleSideBarAttempt>((event, emit) => (state is SideBarOnState)
        ? emit(SideBarOffState())
        : emit(SideBarOnState()));
  }
}
