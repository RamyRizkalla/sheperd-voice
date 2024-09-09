import 'dart:convert';

import 'module_response.dart';

List<CategoryResponse> categoriesListFromJson(String str) =>
    List<CategoryResponse>.from(
        (json.decode(str) as List).map((x) => CategoryResponse.fromJson(x)));

class CategoryResponse implements ModuleResponse {
  final int id;
  @override
  final String title;
  final String itemType;

  CategoryResponse({
    required this.id,
    required this.title,
    required this.itemType,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        id: json["id"],
        title: json["title"],
        itemType: json["item_type"],
      );

  @override
  set title(String title) {
    this.title = title;
  }
}
