part of 'search_input_bloc.dart';

abstract class SearchInputEvent extends Equatable {
  const SearchInputEvent();

  @override
  List<Object> get props => [];
}

class SearchInputAttempt extends SearchInputEvent {
  final String value;
  const SearchInputAttempt({required this.value});

  @override
  List<Object> get props => [value];
}
