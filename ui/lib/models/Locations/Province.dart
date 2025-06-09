import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Locations/DestinationInterface.dart';
import 'City.dart';
import 'package:http/http.dart' as http;

part 'Province.g.dart';

@JsonSerializable()
class Province implements Destination {
  String name;
  String imageUrl;
  String description;
  bool imageNet;

  Province({
    required this.name,
    required this.imageUrl,
    required this.description,
    this.imageNet = false,
  });

  /// Creates a Province Object from JSON formatted object
  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);

  /// Converts Province object to JSON format
  Map<String, dynamic> toJson() => _$ProvinceToJson(this);

  /// Fetches all the provinces
  static Future<List<Province>> fetchAllProvinces() async {
    String url = "https://wijha-417.ew.r.appspot.com/province";
    var response = await Dio().get(url);

    // Convert incoming data to Province model
    List<Province> provinces = [
      for (var province in response.data) Province.fromJson(province)
    ];
    return provinces;
  }

  /// Fetches all the cities within the specified province
  static Future<List<City>> fetchCitiesInProvince(String province) async {
    String url = "https://wijha-417.ew.r.appspot.com/city/$province";
    var response = await Dio().get(url);

    List<City> cities = [for (var city in response.data) City.fromJson(city)];

    return cities;
  }

  final List<City> cityList = [
    City(
        name: 'Riyadh City',
        province: 'Riyadh',
        description:
            'This is a long sample city description to test how long the description can be in a card. AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
        imageUrl: 'assets/images/ALULA.jpg'),
    City(
        name: 'Khobar City',
        province: 'Sharqia',
        description: 'Sample City Description',
        imageUrl: 'assets/images/ALULA.jpg'),
    City(
        name: 'Dhahran',
        province: 'Riyadh',
        description: 'Sample City Description',
        imageUrl: 'assets/images/ALULA.jpg'),
    City(
        name: 'Dammam',
        province: 'Sharqia',
        description: 'Sample City Description',
        imageUrl: 'assets/images/ALULA.jpg'),
    City(
        name: 'Riyadh',
        province: 'Riyadh',
        description: 'Sample City Description',
        imageUrl: 'assets/images/hasa.jpg'),
  ];

  @override
  String toString() {
    return this.name;
  }

// List<province> parseProvince(String responseBody) {
//   // Parses the response body and returns a list of cities within the province
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<province>((json) => province.fromJson(json)).toList();
// }

}
