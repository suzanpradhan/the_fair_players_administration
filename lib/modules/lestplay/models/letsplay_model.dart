class LetsPlayModel {
  final String? uid;
  final String? sportName;
  final String? description;
  final String? type;
  final String? address;

  const LetsPlayModel(
      {this.sportName, this.address, this.type, this.description, this.uid});

  factory LetsPlayModel.fromJson(
          Map<String, dynamic> jsonMapData, String? key) =>
      LetsPlayModel(
          uid: key,
          sportName: jsonMapData["sports"],
          type: jsonMapData["type"],
          address: jsonMapData["address"],
          description: jsonMapData["comments"]);
}
