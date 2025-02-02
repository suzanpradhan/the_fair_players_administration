import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:the_fair_players_administration/modules/core/routes/app_routes.dart';
import 'package:the_fair_players_administration/modules/post/models/post_model.dart';
import 'package:the_fair_players_administration/modules/post/repositories/post_repository.dart';

part 'get_user_post_event.dart';
part 'get_user_post_state.dart';

class GetUserPostBloc extends Bloc<GetUserPostEvent, GetUserPostState> {
  PostRepostitory postRepostitory;
  String? lastDocumentKey;
  GetUserPostBloc({required this.postRepostitory})
      : super(GetUserPostInitial()) {
    on<GetUserPostEvent>((event, emit) {});
    on<GetAllUserPostFirstAttempt>((event, emit) async {
      emit(GetAllUsersPostsLoading());
      List<PostModel> listOfPosts = await getListOfUsers(uid: event.uid, postType: event.type);
      emit(GotAllUsersPostsState(
          listOfPosts: listOfPosts.reversed.toList(), hasMore: true));
    });
    on<GetAllUserPostAttempt>((event, emit) async {
      List<PostModel> listOfPosts = await getListOfUsers(uid: event.uid,postType: PostType.user);
      if (state is GotAllUsersPostsState) {
        emit((state as GotAllUsersPostsState).addListOfPosts(
            listOfPosts: listOfPosts.reversed.toList(),
            hasMore: listOfPosts.isNotEmpty));
      } else {
        emit(GotAllUsersPostsState(
            listOfPosts: listOfPosts.reversed.toList(), hasMore: true));
      }
    });
    on<DeletePostAttempt>((event, emit) => _handleDeletePostEvent(event, emit));
  }

  Future<List<PostModel>> getListOfUsers({required String uid,required PostType postType}) async {
    DataSnapshot listOfPostsSnapshot = await postRepostitory.getAllPostSnapshot(
        uid: uid, key: lastDocumentKey, postType: postType);
    List<PostModel> listOfUsers = listOfPostsSnapshot.children
        .map((DataSnapshot snapshot) => PostModel.fromJson(
            snapshot.value as Map<String, dynamic>, snapshot.key))
        .toList();
    if (listOfUsers.isNotEmpty) {
      lastDocumentKey = listOfUsers[0].uid;
    }
    return listOfUsers;
  }

  _handleDeletePostEvent(
      DeletePostAttempt event, Emitter<GetUserPostState> emit) async {
    postRepostitory.deleteModel(
        key: event.postModel.uid, extraKey: event.postModel.userId, postType: event.postType);
    emit((state as GotAllUsersPostsState)
        .deletePost(postModel: event.postModel));
  }
}
