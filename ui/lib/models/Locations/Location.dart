import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Tours/Category.dart';
import '../Tours/Tour.dart';
import 'DestinationInterface.dart';
part 'Location.g.dart';
// coordinate attribute

@JsonSerializable()
class Location implements Destination {
  String name;
  String description;
  String city;
  String province;
  int cityId;
  int provinceId;
  String imageUrl;
  bool imageNet;
  List<WCategory> categories;

  Location({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.city,
    required this.province,
    this.imageNet = true,
    this.categories = const [],
    this.cityId = 0,
    this.provinceId = 0,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    return this.name;
  }

  final List<Tour> tourList = [];
}
