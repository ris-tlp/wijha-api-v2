import 'package:json_annotation/json_annotation.dart';
part 'tourInclude.g.dart';

@JsonSerializable()
class TourInclude {
  String item;
  String icon;

  TourInclude({required this.item, required this.icon});

  factory TourInclude.fromJson(Map<String, dynamic> json) =>
      _$TourIncludeFromJson(json);

  Map<String, dynamic> toJson() => _$TourIncludeToJson(this);
}
