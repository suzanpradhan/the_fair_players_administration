import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String key;
  final String value;
  const Country({required this.key, required this.value});

  @override
  List<Object?> get props => [value];
}
