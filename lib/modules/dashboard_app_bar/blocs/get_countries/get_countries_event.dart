part of 'get_countries_bloc.dart';

abstract class GetCountriesEvent extends Equatable {
  const GetCountriesEvent();

  @override
  List<Object> get props => [];
}

class GetCountriesAttempt extends GetCountriesEvent {}
