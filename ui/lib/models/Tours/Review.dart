import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Users/User.dart';
part 'Review.g.dart';

@JsonSerializable()
class Review {
  User user;
  double rating;
  String comment;

  Review({
    required this.user,
    required this.rating,
    this.comment = '',
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
