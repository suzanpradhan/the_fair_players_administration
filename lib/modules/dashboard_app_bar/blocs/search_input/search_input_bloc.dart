import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_input_event.dart';
part 'search_input_state.dart';

class SearchInputBloc extends Bloc<SearchInputEvent, SearchInputState> {
  SearchInputBloc() : super(SearchInputInitial()) {
    on<SearchInputEvent>((event, emit) {});
    on<SearchInputAttempt>((event, emit) {
      emit(SearchInputLoadingState());
      emit(SearchInputValueState(value: event.value));
    });
  }
}
