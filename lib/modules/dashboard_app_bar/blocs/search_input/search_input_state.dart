part of 'search_input_bloc.dart';

abstract class SearchInputState extends Equatable {
  const SearchInputState();

  @override
  List<Object> get props => [];
}

class SearchInputInitial extends SearchInputState {}

class SearchInputLoadingState extends SearchInputState {}

class SearchInputValueState extends SearchInputState {
  final String value;
  const SearchInputValueState({required this.value});

  @override
  List<Object> get props => [value];
}
