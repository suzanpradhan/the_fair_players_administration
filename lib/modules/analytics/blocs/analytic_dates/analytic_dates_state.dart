part of 'analytic_dates_bloc.dart';

class AnalyticDatesState extends Equatable {
  final double? startAtTimeStamp;
  final String title;
  final String? country;
  const AnalyticDatesState(
      {this.startAtTimeStamp, required this.title, this.country});

  @override
  List<Object?> get props => [startAtTimeStamp, title, country];

  updateTime({double? startAtTimeStamp, required String title}) {
    return AnalyticDatesState(
        startAtTimeStamp: startAtTimeStamp, title: title, country: country);
  }

  filterByCountry(String country) {
    return AnalyticDatesState(
        startAtTimeStamp: startAtTimeStamp, title: title, country: country);
  }
}
