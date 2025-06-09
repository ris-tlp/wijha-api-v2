import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Users/User.dart';

part 'CustomLocation.g.dart';

@JsonSerializable()
class CustomLocation {
  var name;
  var description;
  var locationFact;
  var locationNumber;
  var image;
  var coordinates;

  CustomLocation.empty();

  // CustomLocation(
  // name, description, locationFact, locationNumber, image, coordinates);

  CustomLocation(
      {required this.name,
      required this.description,
      required this.locationFact,
      required this.locationNumber,
      required this.image,
      required this.coordinates});

  set setName(String name) => this.name = name;

  set setDescription(description) => this.description = description;

  set setLocationFact(locationFact) => this.locationFact = locationFact;

  set setLocationNumber(locationNumber) => this.locationNumber = locationNumber;

  set setImage(image) => this.image = image;

  set setCoordinates(coordinates) => this.coordinates = coordinates;

  /// Converts a CustomLocation object to JSON formatted object
  Map<String, dynamic> toJson() => _$CustomLocationToJson(this);

  /// Creates a CustomLocation Object from JSON formatted object
  factory CustomLocation.fromJson(Map<String, dynamic> json) =>
      _$CustomLocationFromJson(json);

  String toString() {
    return this.name;
  }

  createCustomLocation(XFile image, LatLng coordinates, User user) async {
    // Creates a custom location in the database

    String image_url = await uploadImageBucket(image);
    String url = "https://wijha-417.ew.r.appspot.com/customlocation/create";
    // String url = "http://192.168.100.14:8080/customlocation/create";

    this.image = image_url;
    this.coordinates = coordinates;

    var data = {"custom_location": this.toJson(), "user": user.toJson()};

    var response = await Dio().post(url,
        data: data,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));
  }

  deleteCustomLocation(User user) async {
    String url = "https://wijha-417.ew.r.appspot.com/customlocation/delete";
    // String url = "http://192.168.100.14:8080/customlocation/delete";

    var data = {"custom_location": this.toJson(), "user": user.toJson()};

    var response = await Dio().post(url,
        data: data,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));
  }

  uploadImageBucket(XFile image) async {
    // Takes a file object uploaded from a users gallery and uploads it to cloud storage
    // Returns a URL of the uploaded image

    late String image_url;
    String image_name = image.name;
    String url = "https://wijha-417.ew.r.appspot.com/upload-image";
    // String url = "http://192.168.100.14:8080/upload-image";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var encoded_image = base64.encode(await File(image.path).readAsBytes());

    request.fields["name"] = image_name;
    request.fields["mimetype"] = "image/jpeg";
    request.fields["entity"] = "CustomLocation";
    request.files.add(http.MultipartFile.fromString("image", encoded_image));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    image_url = jsonDecode(responseString)["URL"];

    return image_url;
  }

  /// Fetches a list of CustomLocations with respect to a Tour Guide's ID
  static Future<List<CustomLocation>> fetchCustomLocationsByGuide(
      User user) async {
    String url = "https://wijha-417.ew.r.appspot.com/customlocation";
    // String url = "http://192.168.100.14:8080/customlocation";

    var response = await Dio().post(url,
        data: user.toJson(),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    List<CustomLocation> customLocations = [
      for (var customLocation in response.data)
        CustomLocation.fromJson(customLocation)
    ];

    return customLocations;
  }

  // static List<CustomLocation>? parseCustomLocation(String responseBody) {
  //   // Parses a list of CustomLocation json objects to pure CustomLocation objects

  //   var customLocationJsonList = json.decode(responseBody);
  //   List<CustomLocation> parsedCustomLocationList = [];

  //   for (int i = 0; i < customLocationJsonList.length; i++) {
  //     parsedCustomLocationList
  //         .add(CustomLocation.fromJson(customLocationJsonList[i]));
  //   }

  //   return parsedCustomLocationList;
  // }

  // factory CustomLocation.fromJson(Map<String, dynamic> json) {
  //   // Converts a String formatted as CustomLocation objects to pure CustomLocation objects

  //   return CustomLocation(
  //       name: json["name"] as String,
  //       description: json["description"] as String,
  //       locationFact: json["fact"] as String,
  //       locationNumber: "6",
  //       image: json["image"] as String,
  //       coordinates: json["coordinates"] as String);
  // }

}
