import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Locations/Location.dart';
import '../Tours/Category.dart';
import 'DestinationInterface.dart';
part 'City.g.dart';

@JsonSerializable()
class City implements Destination {
  String name;
  String description;
  String imageUrl;
  String province;
  int provinceId;
  bool imageNet;
  List<WCategory> categories;

  City({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.province,
    this.imageNet = true,
    this.categories = const [],
    this.provinceId = 0,
  });

  /// Creates a City Object from JSON formatted object
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  /// Converts City object to JSON format
  Map<String, dynamic> toJson() => _$CityToJson(this);

  final List<Location> locationList = locationsList;

  @override
  String toString() {
    return this.name;
  }

  static Future<List<Location>> fetchLocationsInCity(String city) async {
    String url = "https://wijha-417.ew.r.appspot.com/location/$city";
    var response = await Dio().get(url);

    List<Location> locations = [
      for (var location in response.data) Location.fromJson(location)
    ];

    return locations;
  }

  // factory City.fromJson(Map<String, dynamic> json) {
  //   // Converts the incoming json object to the City model
  //   return City(
  //       name: json['name'] as String,
  //       imageUrl: json['image'] as String,
  //       province: json['province'] as String,
  //       // coordinates: json['coordinates'],
  //       description: json['description'] as String);
  // }

  List<City> parseCity(String responseBody) {
    // Parses the response body and returns a list of cities within the province
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<City>((json) => City.fromJson(json)).toList();
  }
}
