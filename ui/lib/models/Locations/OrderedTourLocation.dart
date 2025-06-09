import 'package:json_annotation/json_annotation.dart';
part 'OrderedTourLocation.g.dart';

/// Encompasses functionality related to a unique set of locations within a tour.

/// Difference between OrderedTourLocation and other Location classes is the
/// locationNumber attribute, signifying what order each location falls within each tour.
@JsonSerializable()
class OrderedTourLocation {
  late String name;
  late String description;
  late String locationFact;
  late String locationNumber;
  late String imageUrl;
  late String coordinates;

  OrderedTourLocation.empty();

  OrderedTourLocation(
      {required this.name,
      required this.description,
      required this.locationFact,
      required this.locationNumber,
      required this.imageUrl,
      required this.coordinates});

  factory OrderedTourLocation.fromJson(Map<String, dynamic> json) =>
      _$OrderedTourLocationFromJson(json);

  Map<String, dynamic> toJson() => _$OrderedTourLocationToJson(this);
}
