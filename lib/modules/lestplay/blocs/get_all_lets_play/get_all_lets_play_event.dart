part of 'get_all_lets_play_bloc.dart';

abstract class GetAllLetsPlayEvent extends Equatable {
  const GetAllLetsPlayEvent();

  @override
  List<Object> get props => [];
}

class GetAllLetsPlayFirstAttempt extends GetAllLetsPlayEvent {}

class GetAllLetsPlayAttempt extends GetAllLetsPlayEvent {}

class DeleteLetsPlayAttempt extends GetAllLetsPlayEvent {
  final LetsPlayModel letsPlayModel;
  const DeleteLetsPlayAttempt({required this.letsPlayModel});

  @override
  List<Object> get props => [letsPlayModel];
}
