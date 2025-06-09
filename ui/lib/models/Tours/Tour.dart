import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Locations/OrderedTourLocation.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/models/Tours/Review.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/Tourist.dart';
import 'package:wijha/models/Users/User.dart';
import 'dart:io';

import 'package:wijha/screens/tour/QR/cryptography.dart';

part 'Tour.g.dart';

@JsonSerializable()
class Tour {
  int capacity;
  String id;
  static int travelPoints = 25;
  double rating;
  double price;
  String title;
  String description;
  Guide guide;
  City city;
  DateTime dateTime;
  List<String> images;
  List<WCategory> categories;
  List<TourInclude> included;
  late List<Fact> facts;
  late List<Location> destinations;
  late List<OrderedTourLocation> orderedLocations;
  int status;

  /// 0 for created but not started ; 1 for started ; -1 for finished
  int progress = 0;

  /// For tracker to know how far the Guide updated the tour

  /// Temp
  // List<User> registered = [];
  List<User> attendance = [];
  List<Review> reviews = [];
  List<Request> registrationRequests = [];

  Tour({
    required this.capacity,
    required this.title,
    required this.price,
    required this.images,
    required this.guide,
    required this.destinations,
    required this.categories,
    required this.facts,
    required this.description,
    required this.rating,
    required this.city,
    required this.dateTime,
    required this.included,
    required this.id,
    this.status = 0,
  });

  Tour.orderedLocationsConstructor(
      {required this.capacity,
      required this.title,
      required this.price,
      required this.images,
      required this.guide,
      required this.categories,
      required this.description,
      required this.rating,
      required this.city,
      required this.dateTime,
      required this.included,
      required this.orderedLocations,
      required this.id,
      this.status = 0

      /// Added because error was generated
      });

  /// Creates a Tour Object from JSON formatted object
  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  /// Converts Tour object to JSON format
  Map<String, dynamic> toJson() => _$TourToJson(this);

  /// Takes a file object uploaded from a users gallery and uploads it to cloud storage
  /// Returns a URL of the uploaded image

  static uploadImageBucket(XFile image) async {
    late String image_url;
    String image_name = image.name;
    String url = "https://wijha-417.ew.r.appspot.com/upload-image";
    // String url = "http://192.168.100.14:8080/upload-image";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var encoded_image = base64.encode(await File(image.path).readAsBytes());

    request.fields["name"] = image_name;
    request.fields["mimetype"] = "image/jpeg";
    request.fields["entity"] = "Tour";
    request.files.add(http.MultipartFile.fromString("image", encoded_image));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    image_url = jsonDecode(responseString)["URL"];

    return image_url;
  }

  /// Ends a tour
  void endTour() {
    status = -1;
  }

  void incrementStep() {
    progress += 1;
  }

  void decrementStep() {
    progress -= 1;
  }

  /// Listens for changes on the currently active tour for a specific guide
  static changeListener() async {
    await Firebase.initializeApp(); //idek
    // var db = FirebaseFirestore.instance;
    // final docRef = db.collection("Tour").doc("0NGCdUBI55zozk1Tu2fQ");
    // docRef.snapshots().listen(
    //       (event) => print("current data: ${event.data()}"),
    //       onError: (error) => print("Listen failed: $error"),
    //     );
  }

  /// Sends a POST request to create a new Tour
  dynamic createTour() async {
    // String url = "https://wijha-417.ew.r.appspot.com/tour/create";
    String url = "https://wijha-417.ew.r.appspot.com/tour/create";

    List<OrderedTourLocation> locations =
        this.convertLocationsToOrderedLocations();
    locations.map((location) => location.toJson());

    var data = this.toJson();
    data["locations"] = locations;
    data["province"] = this.destinations[0].province;
    // data["qr"] = Cryptography.encryptAES(this.title.toString());

    var response = await Dio().post(url,
        data: data,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    print(response.data);
  }

  void registerTouristInTour(User user) async {
    // String url = "https://wijha-417.ew.r.appspot.com/tour/register";
    String url = "https://wijha-417.ew.r.appspot.com/tour/register";

    var response = await Dio().post(url,
        data: {"tour": this.toJson(), "tourist": user.toJson()},
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));
  }

  static Future<List<Tour>> fetchActiveTours(String guideID) async {
    return fetchInactiveTours(guideID, true);
  }

  static Future<List<Tour>> fetchInactiveTours(
      String guideUsername, bool active) async {
    String url;
    if (active) {
      url =
          "https://wijha-417.ew.r.appspot.com/tour/guide/$guideUsername/active";
    } else {
      url = "https://wijha-417.ew.r.appspot.com/tour/guide/$guideUsername";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Iterable r = json.decode(response.body);

      // Parse incoming list of tours to the Tour model
      List<Tour> tours =
          List<Tour>.from(r.map((model) => Tour.fromJson(model)));

      // For each orderedLocation list within the Tour, convert them
      // to their respective Facts and Destinations lists
      for (int i = 0; i < tours.length; i++) {
        List<dynamic> unmergedOrderedLocations = tours[i]
            .convertOrderedLocationsToLocations(tours[i].orderedLocations);

        tours[i].destinations = unmergedOrderedLocations[0];
        tours[i].facts = unmergedOrderedLocations[1];
      }

      return tours;
    } else {
      throw Exception("Failed to load.");
    }
  }

  /// Fetches all the inactive tours of a guide
  static Future<List<Tour>> fetchHistoryTours(String guideUsername) async {
    String url =
        "https://wijha-417.ew.r.appspot.com/tour/history/$guideUsername";
    var response = await Dio().get(url);

    List<Tour> tours = [for (var tour in response.data) Tour.fromJson(tour)];

    // For each orderedLocation list within the Tour, convert them
    // to their respective Facts and Destinations lists
    for (int i = 0; i < tours.length; i++) {
      List<dynamic> unmergedOrderedLocations = tours[i]
          .convertOrderedLocationsToLocations(tours[i].orderedLocations);

      tours[i].destinations = unmergedOrderedLocations[0];
      tours[i].facts = unmergedOrderedLocations[1];
    }

    return tours;
  }

  static Future<List<Tour>> fetchToursInProvince(String provinceName) async {
    String url =
        "https://wijha-417.ew.r.appspot.com/tour/province/$provinceName";
    var response = await Dio().get(url);

    List<Tour> tours = [for (var tour in response.data) Tour.fromJson(tour)];

    // For each orderedLocation list within the Tour, convert them
    // to their respective Facts and Destinations lists
    for (int i = 0; i < tours.length; i++) {
      List<dynamic> unmergedOrderedLocations = tours[i]
          .convertOrderedLocationsToLocations(tours[i].orderedLocations);

      tours[i].destinations = unmergedOrderedLocations[0];
      tours[i].facts = unmergedOrderedLocations[1];
    }

    return tours;
  }

  /// Takes a list of OrderedTourLocations and converts it to
  /// a corresponding list of Facts and Locations
  List<dynamic> convertOrderedLocationsToLocations(
      List<OrderedTourLocation> orderedLocations) {
    List<Fact> facts = [];
    List<Location> locations = [];

    for (int i = 0; i < this.orderedLocations.length; i++) {
      Location tempLocation = new Location(
          name: orderedLocations[i].name,
          description: orderedLocations[i].description,
          city: "",
          province: "",
          imageUrl: orderedLocations[i].imageUrl,
          categories: []);

      locations.add(tempLocation);
      facts.add(new Fact(
          content: orderedLocations[i].locationFact, location: tempLocation));
    }
    return [locations, facts];
  }

  /// Takes a list of Locations and their corresponding Location Facts
  /// and converts them to a list of OrderedTourLocations
  ///
  /// Locations and Facts lists will always be the same length and their order
  /// will always be preserved
  List<OrderedTourLocation> convertLocationsToOrderedLocations() {
    List<OrderedTourLocation> tourLocations = [];

    // Goes through each Location and Fact and merges into 1 OrderedTourLocation
    for (int i = 0; i < this.facts.length; i++) {
      tourLocations.add(new OrderedTourLocation(
          name: this.destinations[i].name,
          description: this.destinations[i].description,
          locationFact: this.facts[i].content,
          locationNumber: i.toString(),
          imageUrl: this.destinations[i].imageUrl,
          coordinates: ""));
    }

    return tourLocations;
  }

  /// Adds a review to the current review list
  void addReview(Review review) {
    this.reviews.add(review);

    double total = 0;
    for (Review x in reviews) {
      total += x.rating;
    }

    this.rating = total / double.parse(reviews.length.toString());
  }

  /// Adds a request to the current list of requests
  void addRequest(User user) {
    Request request = Request(user: user, date: DateTime.now());
    this.registrationRequests.add(request);
  }

  /// Removes a request to the current list of requests
  /// Most likely unneeded
  void removeRequest(User user) {
    this.registrationRequests.remove(user);
  }

  /// Unneeded
  // void acceptRequest(User user) {
  //   this.registrationRequests.remove(user);
  //   this.attendance.add(user);
  // }

  /// Marks user as attended when they scan QR code
  void markAttendance(User user) {
    //registrationRequests.firstWhere((request) => request.user == user).)
    addAttendance(user);
  }

  /// Marks user as attended when they scan QR code
  void addAttendance(User user) {
    attendance.add(user);
  }

  /// Fetches both Wijha and Custom Locations within a Tour
  Future<List<OrderedTourLocation>> fetchLocationsInTour(int tourID) async {
    // Returns a list of Locations within a unique Tour

    // Placeholder locations
    List<OrderedTourLocation> locations = [
      new OrderedTourLocation(
          name: "Location 1",
          description: "Description 1",
          locationFact: "Location Fact 1",
          locationNumber: "1",
          imageUrl: "Put a URL here",
          coordinates: "coordinates"),
      new OrderedTourLocation(
          name: "Location2",
          description: "Description 2",
          locationFact: "Location Fact 2",
          locationNumber: "2",
          imageUrl: "Put a URL here",
          coordinates: "coordinates"),
      new OrderedTourLocation(
          name: "Location3",
          description: "Description 3",
          locationFact: "Location Fact 3",
          locationNumber: "3",
          imageUrl: "Put a URL here",
          coordinates: "coordinates"),
    ];

    return locations;
  }
}

@JsonSerializable()
class Request {
  User user;
  DateTime date;
  int status; // 0: pending, -1: rejected, 1: accepted
  int participants;

  Request({
    required this.user,
    required this.date,
    this.status = 0,
    this.participants = 1,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  approve() {
    status = 1;
  }

  deny() {
    status = -1;
  }
}
