part of 'analytic_dates_bloc.dart';

class AnalyticDatesState extends Equatable {
  final double startAtTimeStamp;
  final String title;
  final String? country;
  const AnalyticDatesState(
      {required this.startAtTimeStamp, required this.title, this.country});

  @override
  List<Object?> get props => [startAtTimeStamp, country];

  filterByCountry(String country) {
    return AnalyticDatesState(
        startAtTimeStamp: startAtTimeStamp, title: title, country: country);
  }
}
