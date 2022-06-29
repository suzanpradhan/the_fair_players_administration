part of 'get_all_clubs_bloc.dart';

abstract class GetAllClubsEvent extends Equatable {
  const GetAllClubsEvent();

  @override
  List<Object> get props => [];
}

class GetAllClubsFirstAttempt extends GetAllClubsEvent {}

class GetAllClubsAttempt extends GetAllClubsEvent {}

class DeleteClubAttempt extends GetAllClubsEvent {
  final ClubModel clubModel;
  const DeleteClubAttempt({required this.clubModel});

  @override
  List<Object> get props => [clubModel];
}
