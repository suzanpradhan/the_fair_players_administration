part of 'get_user_post_bloc.dart';

abstract class GetUserPostEvent extends Equatable {
  const GetUserPostEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserPostFirstAttempt extends GetUserPostEvent {
  final String uid;
  final PostType type;

  const GetAllUserPostFirstAttempt({required this.uid, required this.type});

  @override
  List<Object> get props => [uid];
}

class GetAllUserPostAttempt extends GetUserPostEvent {
  final String uid;

  const GetAllUserPostAttempt({required this.uid});

  @override
  List<Object> get props => [uid];
}

class DeletePostAttempt extends GetUserPostEvent {
  final PostModel postModel;
  final PostType postType;

  const DeletePostAttempt({required this.postModel,required this.postType});

  @override
  List<Object> get props => [postModel];
}
