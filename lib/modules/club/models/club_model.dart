class ClubModel {
  final String? uid;
  final String? clubName;
  final int? totalMembers;
  final String? clubImage;
  final String? adminName;
  final String? adminImage;
  final String? adminUID;

  const ClubModel(
      {this.clubName,
      this.totalMembers,
      this.clubImage,
      this.adminName,
      this.adminImage,
      this.adminUID,
      this.uid});

  factory ClubModel.fromJson(Map<String, dynamic> jsonMapData, String? key) =>
      ClubModel(
        uid: key,
        clubName: jsonMapData["clubName"],
        totalMembers: jsonMapData["clubMembers"],
        adminName: jsonMapData["adminName"],
        clubImage: jsonMapData["clubImage"],
        adminImage: jsonMapData["adminImage"],
        adminUID: jsonMapData["adminUID"],
      );
}
