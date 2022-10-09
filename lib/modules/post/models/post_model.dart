import 'dart:collection';

class PostModel {
  final String? uid;
  final String? userId;
  final String? title;
  final String? description;
  final String? details;
  final String? postImage;
  final int? comments;
  final int? likes;
  final String? type;

  const PostModel({
    this.title,
    this.description,
    this.uid,
    this.postImage,
    this.userId,
    this.details,
    this.comments,
    this.likes,
    this.type,
  });

  factory PostModel.fromJson(Map<String, dynamic> jsonMapData, String? key) => PostModel(
      uid: key,
      userId: jsonMapData["userID"],
      description: jsonMapData["description"],
      details: jsonMapData["details"],
      title: jsonMapData["title"],
      postImage: jsonMapData["postImage"],
      comments: jsonMapData["Comments"],
      likes: (jsonMapData["Likes"] as LinkedHashMap<dynamic, dynamic>?)
          ?.map((key, value) {
        return MapEntry(key, value);
      }).length,
      type: jsonMapData["type"],
    );
}
