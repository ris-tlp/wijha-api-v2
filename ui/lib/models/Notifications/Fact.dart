import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'NotificationModel.dart';
part 'Fact.g.dart';

@JsonSerializable()
class Fact implements NotificationModel {
  Location location;
  String content;
  int expVal;
  String type = "fact";

  Fact({
    required this.content,
    required this.location,
    this.expVal = 25,
  });

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);

  Map<String, dynamic> toJson() => _$FactToJson(this);
}
