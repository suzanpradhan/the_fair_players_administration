part of 'get_countries_bloc.dart';

abstract class GetCountriesEvent extends Equatable {
  const GetCountriesEvent();

  @override
  List<Object> get props => [];
}

class GetCountriesAttempt extends GetCountriesEvent {}

class SearchCountriesAttempt extends GetCountriesEvent {
  final String searchString;
  final List<Country> listOfCountries;
  const SearchCountriesAttempt(
      {required this.searchString, required this.listOfCountries});

  @override
  List<Object> get props => [searchString, listOfCountries];
}
