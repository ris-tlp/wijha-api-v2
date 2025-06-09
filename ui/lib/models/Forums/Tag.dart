import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Tag.g.dart';

@JsonSerializable()
class Tag {
  String title;
  String imageUrl;

  Tag({required this.title, required this.imageUrl});

  String get getTitle => this.title;

  set setTitle(String title) => this.title = title;

  get getImageUrl => this.imageUrl;

  set setImageUrl(imageUrl) => this.imageUrl = imageUrl;

  /// Creates a Tag Object from JSON formatted object
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  /// Converts Tag object to JSON format
  Map<String, dynamic> toJson() => _$TagToJson(this);

  /// Returns a set of Tags to be chosen from while creating
  /// a forum post
  static Future<List<Tag>> getTagsForPost() async {
    String url = "https://wijha-417.ew.r.appspot.com/forum/tag";
    var response = await Dio().get(url);

    List<Tag> tags = [for (var tag in response.data) Tag.fromJson(tag)];

    return tags;
  }

  String toString() {
    return this.getTitle;
  }
}
