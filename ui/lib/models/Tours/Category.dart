import 'package:json_annotation/json_annotation.dart';
part 'Category.g.dart';

@JsonSerializable()
class WCategory {
  String title;
  String icon;

  WCategory({required this.title, required this.icon});

  factory WCategory.fromJson(Map<String, dynamic> json) =>
      _$WCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$WCategoryToJson(this);
}
