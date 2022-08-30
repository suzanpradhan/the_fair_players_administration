import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_fair_players_administration/modules/core/error_handling/failure.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/models/country_model.dart';
import 'package:the_fair_players_administration/modules/dashboard_app_bar/repository/country_repository.dart';

part 'get_countries_event.dart';
part 'get_countries_state.dart';

class GetCountriesBloc extends Bloc<GetCountriesEvent, GetCountriesState> {
  final CountryRepository countryRepository;
  GetCountriesBloc({required this.countryRepository})
      : super(GetCountriesInitial()) {
    on<GetCountriesEvent>((event, emit) {});
    on<GetCountriesAttempt>(
        (event, emit) => _handleGetCountriesAttemptEvent(event, emit));
    on<SearchCountriesAttempt>(
        (event, emit) => _handleSearchAttemptEvent(event, emit));
  }

  _handleGetCountriesAttemptEvent(
      GetCountriesAttempt event, Emitter<GetCountriesState> emit) async {
    try {
      emit(GetCountriesLoadingState());
      List<Country> listOfCountries = await countryRepository.getAllCountries();
      emit(GotCountriesSuccessState(countries: listOfCountries));
    } catch (e) {
      emit(GetCountriesFailedState(failure: Failure(message: e.toString())));
    }
  }

  _handleSearchAttemptEvent(
      SearchCountriesAttempt event, Emitter<GetCountriesState> emit) async {
    emit(GotCountriesSuccessState(
        countries: (state as GotCountriesSuccessState)
            .searchCountries(event.searchString)));
  }
}
