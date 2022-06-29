part of 'analytic_dates_bloc.dart';

class AnalyticDatesState extends Equatable {
  final double startAtTimeStamp;
  final String title;
  const AnalyticDatesState(
      {required this.startAtTimeStamp, required this.title});

  @override
  List<Object> get props => [startAtTimeStamp];
}
