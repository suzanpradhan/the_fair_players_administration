import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/analytic_repository.dart';

part 'analytic_dates_event.dart';
part 'analytic_dates_state.dart';

class AnalyticDatesBloc extends Bloc<AnalyticDatesEvent, AnalyticDatesState> {
  AnalyticDatesBloc()
      : super(AnalyticDatesState(
            title: "last 30 days",
            startAtTimeStamp: DateTime.now()
                .subtract(const Duration(days: 30))
                .millisecondsSinceEpoch
                .toDouble())) {
    on<AnalyticDatesEvent>((event, emit) async {
      emit(AnalyticDatesState(
          title: "last 30 days",
          startAtTimeStamp: DateTime.now()
              .subtract(const Duration(days: 30))
              .millisecondsSinceEpoch
              .toDouble()));
    });
    on<ChangeToDayAnalytic>((event, emit) => emit(AnalyticDatesState(
        title: "daily",
        startAtTimeStamp: DateTime.now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch
            .toDouble())));
    on<ChangeToWeekAnalytic>((event, emit) => emit(AnalyticDatesState(
        title: "last week",
        startAtTimeStamp: DateTime.now()
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch
            .toDouble())));
    on<ChangeToMonthAnalytic>((event, emit) => emit(AnalyticDatesState(
        title: "last 30 days",
        startAtTimeStamp: DateTime.now()
            .subtract(const Duration(days: 30))
            .millisecondsSinceEpoch
            .toDouble())));
    on<ChangeCountryAnalytic>(
        (event, emit) => emit(state.filterByCountry(event.country)));
  }
}
