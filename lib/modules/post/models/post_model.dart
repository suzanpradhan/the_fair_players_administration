class PostModel {
  final String? uid;
  final String? title;
  final String? description;
  final String? postImage;

  const PostModel({this.title, this.description, this.uid, this.postImage});

  factory PostModel.fromJson(Map<String, dynamic> jsonMapData, String? key) =>
      PostModel(
        uid: key,
        description: jsonMapData["description"],
        title: jsonMapData["title"],
        postImage: jsonMapData["postImage"],
      );
}
