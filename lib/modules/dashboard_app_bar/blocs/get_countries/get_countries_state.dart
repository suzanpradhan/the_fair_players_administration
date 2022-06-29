part of 'get_countries_bloc.dart';

abstract class GetCountriesState extends Equatable {
  const GetCountriesState();

  @override
  List<Object> get props => [];
}

class GetCountriesInitial extends GetCountriesState {}

class GetCountriesLoadingState extends GetCountriesState {}

class GotCountriesSuccessState extends GetCountriesState {
  final List<Country> countries;
  const GotCountriesSuccessState({required this.countries});

  @override
  List<Object> get props => [countries];
}

class GetCountriesFailedState extends GetCountriesState {
  final Failure failure;
  const GetCountriesFailedState({required this.failure});

  @override
  List<Object> get props => [failure];
}
