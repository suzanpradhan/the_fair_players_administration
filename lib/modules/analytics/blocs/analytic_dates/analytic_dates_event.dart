part of 'analytic_dates_bloc.dart';

abstract class AnalyticDatesEvent extends Equatable {
  const AnalyticDatesEvent();

  @override
  List<Object> get props => [];
}

class ChangeToDayAnalytic extends AnalyticDatesEvent {}

class ChangeToWeekAnalytic extends AnalyticDatesEvent {}

class ChangeToMonthAnalytic extends AnalyticDatesEvent {}

class ChangeCountryAnalytic extends AnalyticDatesEvent {
  final String country;
  const ChangeCountryAnalytic({required this.country});
}
