class MosqueModel {
  int id;
  String name;
  double lat;
  double long;
  String? photoUrl;

  MosqueModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
     this.photoUrl,
  });

  factory MosqueModel.fromJson(Map<String, dynamic> json) {
    return MosqueModel(
        id: json['id'],
        name: json['name'],
        lat: json["latitude"],
        long: json["longitude"],
        photoUrl: json["photo_url"]);
  }
}
