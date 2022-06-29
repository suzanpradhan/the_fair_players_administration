class CompetitionModel {
  final String? uid;
  final String? competitionName;
  final String? competitionType;
  final String? sportsName;
  final String? address;
  final int? totalMembers;
  final String? adminName;
  final String? description;
  final String? adminImage;
  final String? adminUID;

  const CompetitionModel(
      {this.competitionName,
      this.totalMembers,
      this.description,
      this.competitionType,
      this.address,
      this.sportsName,
      this.adminName,
      this.adminImage,
      this.adminUID,
      this.uid});

  factory CompetitionModel.fromJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      CompetitionModel(
          uid: key,
          competitionName: jsonMapData["competitionName"],
          totalMembers: jsonMapData["totalMembers"],
          adminName: jsonMapData["adminName"],
          adminImage: (jsonMapData["adminImage"] != null &&
                  jsonMapData["adminImage"] != "null")
              ? jsonMapData["adminImage"]
              : null,
          adminUID: jsonMapData["adminUID"],
          competitionType: jsonMapData["competitionType"],
          address: jsonMapData["address"],
          description: jsonMapData["comments"],
          sportsName: jsonMapData["sportsName"]);
}
