import 'package:get/get.dart';

class MoviesResponseModel {
  int? id;
  String? title;
  String? posterUrl;
  String? imdbId;
  RxBool isFavorite = false.obs; // Reactive property

  MoviesResponseModel({
    this.id,
    this.title,
    this.posterUrl,
    this.imdbId,
    bool isFavorite = false, // Default value
  }) : isFavorite = RxBool(isFavorite);

  // fromJson method to convert a Map into a MoviesResponseModel object
  factory MoviesResponseModel.fromJson(Map<String, dynamic> json) {
    return MoviesResponseModel(
      id: json["id"],
      title: json["title"],
      posterUrl: json["posterURL"],
      imdbId: json["imdbId"],
      isFavorite: json["isFavorite"] ?? false,
    );
  }

  // toJson method to convert the object back into a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterURL': posterUrl,
      'imdbId': imdbId,
      'isFavorite': isFavorite.value,
    };
  }
}
