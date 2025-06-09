import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/Tourist.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  String userName;
  String profilePicture;
  bool netImage;
  int travelPoints;
  double rating;
  String type;
  String location;

  User({
    required this.userName,
    this.profilePicture = 'assets/logos/wijhaLogo.png',
    this.netImage = false,
    this.travelPoints = 0,
    this.rating = 5.0,
    this.type = "guest",
    this.location = 'Dhahran',
  });

  static loginUser(String userName, String password) async {
    String url = "https://wijha-417.ew.r.appspot.com/login";
    var data = {"userName": userName, "password": password};
    var response = await Dio().post(url,
        data: jsonEncode(data),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    // print(response.data[0]["password"]);

    if (response.data.length == 0) {
      return null;
    } else if (response.data[0]["type"] == "tourist") {
      var data = response.data[0];
      Tourist tourist = new Tourist(
        userName: data["userName"]!,
        profilePicture: data["profilePicture"]!,
        rating: double.parse(data["rating"]),
        travelPoints: data["travelPoints"],
      );

      return [tourist, 1];
    } else {
      var data = response.data[0];
      Guide guide = new Guide(
          userName: data["userName"],
          about: data["about"],
          location: data["location"],
          rating: double.parse(data["rating"]),
          profilePicture: data["profilePicture"]);

      return [guide, 2];
    }
  }

  addPoints(int points) {
    this.travelPoints += points;
  }

  getLevel() {
    return (travelPoints ~/ 100).toString();
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Returns progress to next level
  getProgress() {
    return (travelPoints / 100) * 100 ~/ 1;
  }
}
