import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    on<ChangeToDayAnalytic>((event, emit) => emit(state.updateTime(
        title: "daily",
        startAtTimeStamp: DateTime.now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch
            .toDouble())));
    on<ChangeToWeekAnalytic>((event, emit) => emit(state.updateTime(
        title: "last week",
        startAtTimeStamp: DateTime.now()
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch
            .toDouble())));
    on<ChangeToMonthAnalytic>((event, emit) => emit(state.updateTime(
        title: "last 30 days",
        startAtTimeStamp: DateTime.now()
            .subtract(const Duration(days: 30))
            .millisecondsSinceEpoch
            .toDouble())));

    on<ChangeToAllAnalytic>((event, emit) =>
        emit(state.updateTime(title: "all", startAtTimeStamp: null)));
    on<ChangeCountryAnalytic>(
        (event, emit) => emit(state.filterByCountry(event.country)));
  }
}
