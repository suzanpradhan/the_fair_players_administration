part of 'get_user_post_bloc.dart';

abstract class GetUserPostState extends Equatable {
  const GetUserPostState();

  @override
  List<Object> get props => [];
}

class GetUserPostInitial extends GetUserPostState {}

class GetAllUsersPostsLoading extends GetUserPostState {}

class GotAllUsersPostsState extends GetUserPostState {
  final List<PostModel> listOfPosts;
  final bool hasMore;
  const GotAllUsersPostsState(
      {required this.listOfPosts, required this.hasMore});

  GotAllUsersPostsState addListOfPosts(
      {required List<PostModel> listOfPosts, bool? hasMore}) {
    if (listOfPosts.isNotEmpty) {
      this.listOfPosts.addAll(listOfPosts);
    }
    return GotAllUsersPostsState(
        listOfPosts: this.listOfPosts, hasMore: listOfPosts.isNotEmpty);
  }
}

class GetAllUsersPostsFailedState extends GetUserPostState {
  final String errorMessage;
  const GetAllUsersPostsFailedState({required this.errorMessage});
}