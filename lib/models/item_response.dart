import 'dart:convert';

import 'module_response.dart';

List<T> listFromJson<T extends ModuleResponse>(
    String str, T Function(Map<String, dynamic> json) converter) {
  return List<T>.from((json.decode(str) as List).map((x) => converter(x)));
}

class ItemResponse implements ModuleResponse {
  final String id;
  @override
  final String title;
  final String itemType;
  final String? youtubeLink;
  final String updatedAt;

  DateTime get updatedAtDate => DateTime.parse(updatedAt);

  ItemResponse({
    required this.id,
    required this.title,
    required this.itemType,
    required this.youtubeLink,
    required this.updatedAt,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) => ItemResponse(
        id: json["id"],
        title: json["title"],
        itemType: json["item_type"],
        youtubeLink: json["youtube_link"],
        updatedAt: json["updated_at"],
      );

  @override
  set title(String _title) {
    title = _title;
  }
}
