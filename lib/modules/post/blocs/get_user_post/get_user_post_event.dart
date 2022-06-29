part of 'get_user_post_bloc.dart';

abstract class GetUserPostEvent extends Equatable {
  const GetUserPostEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserPostFirstAttempt extends GetUserPostEvent {
  final String uid;
  const GetAllUserPostFirstAttempt({required this.uid});

  @override
  List<Object> get props => [uid];
}

class GetAllUserPostAttempt extends GetUserPostEvent {
  final String uid;
  const GetAllUserPostAttempt({required this.uid});

  @override
  List<Object> get props => [uid];
}
