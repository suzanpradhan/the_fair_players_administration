class PostModel {
  final String? uid;
  final String? userId;
  final String? title;
  final String? description;
  final String? postImage;

  const PostModel(
      {this.title, this.description, this.uid, this.postImage, this.userId});

  factory PostModel.fromJson(Map<String, dynamic> jsonMapData, String? key) =>
      PostModel(
        uid: key,
        userId: jsonMapData["userID"],
        description: jsonMapData["description"],
        title: jsonMapData["title"],
        postImage: jsonMapData["postImage"],
      );
}
