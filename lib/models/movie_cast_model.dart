class MovieCastModel {
  MovieCastModel({
    required this.id,
    required this.cast,
  });

  int? id;
  List<Cast> cast;

  factory MovieCastModel.fromJson(Map<String, dynamic> json) => MovieCastModel(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
      };
}

class Cast {
  Cast({
    required this.name,
    required this.character,
    required this.knownForDepartment,
    this.profilePath,
  });

  String name;
  String character;
  String knownForDepartment;
  String? profilePath;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        name: json["name"],
        character: json["character"],
        knownForDepartment: json["known_for_department"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "character": character,
        "known_for_department": knownForDepartment,
        "profile_path": profilePath,
      };
}
