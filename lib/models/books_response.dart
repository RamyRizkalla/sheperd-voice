import 'dart:convert';

List<BooksResponse> languageListFromJson(String str) =>
    List<BooksResponse>.from(
        json.decode(str).map((x) => BooksResponse.fromJson(x)));

class BooksResponse {
  final int id;
  final String name;
  final String uniqueSeoCode;

  BooksResponse({
    required this.id,
    required this.name,
    required this.uniqueSeoCode,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) => BooksResponse(
        id: json["id"],
        name: json["name"],
        uniqueSeoCode: json["unique_seo_code"],
      );
}
