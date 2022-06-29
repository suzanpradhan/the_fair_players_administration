class TeamModel {
  final String? uid;
  final String? teamName;
  final int? totalMembers;
  final String? teamImage;
  final String? sportName;
  final String? adminName;
  final String? adminImage;
  final String? adminUID;

  const TeamModel(
      {this.teamName,
      this.totalMembers,
      this.teamImage,
      this.sportName,
      this.adminName,
      this.adminImage,
      this.adminUID,
      this.uid});

  factory TeamModel.fromJson(Map<String, dynamic> jsonMapData, String? key) =>
      TeamModel(
        uid: key,
        teamName: jsonMapData["teamName"],
        totalMembers: jsonMapData["teamMembers"],
        sportName: jsonMapData["sportName"],
        adminName: jsonMapData["adminName"],
        teamImage: (jsonMapData["teamImage"] != null &&
                jsonMapData["teamImage"] != "null")
            ? jsonMapData["teamImage"]
            : null,
        adminImage: (jsonMapData["adminImage"] != null &&
                jsonMapData["adminImage"] != "null")
            ? jsonMapData["adminImage"]
            : null,
        adminUID: jsonMapData["adminUID"],
      );
}
