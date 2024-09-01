import 'dart:convert';

import 'module_response.dart';

List<T> listFromJson<T extends ModuleResponse>(
    String str, T Function(Map<String, dynamic> json) converter) {
  return List<T>.from((json.decode(str) as List).map((x) => converter(x)));
}

List<FilmResponse> filmsListFromJson(String str) => List<FilmResponse>.from(
    (json.decode(str) as List).map((x) => FilmResponse.fromJson(x)));

class FilmResponse implements ModuleResponse {
  final int id;
  @override
  final String title;
  final String itemType;
  final String youtubeLink;
  final int order;

  FilmResponse({
    required this.id,
    required this.title,
    required this.itemType,
    required this.youtubeLink,
    required this.order,
  });

  factory FilmResponse.fromJson(Map<String, dynamic> json) => FilmResponse(
        id: json["id"],
        title: json["title"],
        itemType: json["item_type"],
        youtubeLink: json["youtube_link"],
        order: json["order"],
      );

  @override
  set title(String _title) {
    title = _title;
  }
}
