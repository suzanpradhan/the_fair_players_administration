part of 'get_countries_bloc.dart';

abstract class GetCountriesState {
  const GetCountriesState();
}

class GetCountriesInitial extends GetCountriesState {}

class GetCountriesLoadingState extends GetCountriesState {}

class GotCountriesSuccessState extends GetCountriesState {
  final List<Country> countries;
  const GotCountriesSuccessState({required this.countries});
  searchCountries(String value) {
    return countries.where((element) => element.value.contains(value)).toList();
  }
}

class GetCountriesFailedState extends GetCountriesState {
  final Failure failure;
  const GetCountriesFailedState({required this.failure});
}
