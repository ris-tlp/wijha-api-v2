import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Locations/OrderedTourLocation.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/User.dart';

part 'TourTracker.g.dart';

@JsonSerializable()
class TourTracker {
  String id;
  List<User> attending;
  List<User> registered;
  int currentLocation;
  Guide guide;
  Tour tour;
  bool active;

  TourTracker(
      {this.id = "0",
      required this.attending,
      required this.registered,
      required this.currentLocation,
      required this.guide,
      required this.tour,
      required this.active});

  factory TourTracker.fromJson(Map<String, dynamic> json) =>
      _$TourTrackerFromJson(json);

  Map<String, dynamic> toJson() => _$TourTrackerToJson(this);

  get getAttending => this.attending;

  set setAttending(attending) => this.attending = attending;

  get getRegistered => this.registered;

  set setRegistered(registered) => this.registered = registered;

  get getCurrentLocation => this.currentLocation;

  set setCurrentLocation(currentLocation) =>
      this.currentLocation = currentLocation;

  get getGuide => this.guide;

  set setGuide(guide) => this.guide = guide;

  get getTour => this.tour;

  set setTour(tour) => this.tour = tour;

  get getActive => this.active;

  set setActive(active) => this.active = active;

  /// Fetches the tracker of a specific tour
  static Future<TourTracker> fetchTrackerByTour(Tour tour) async {
    String url = "https://wijha-417.ew.r.appspot.com/tour/tracker";
    var response = await Dio().post(url,
        data: {"tour": tour.id},
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    TourTracker tracker = TourTracker.fromJson(response.data);

    List<dynamic> unmergedOrderedLocations =
        tracker.tour.convertOrderedLocationsToLocations(tour.orderedLocations);

    tracker.tour.destinations = unmergedOrderedLocations[0];
    tracker.tour.facts = unmergedOrderedLocations[1];

    inspect(tracker);
    return tracker;
  }

  /// Takes a list of OrderedTourLocations and converts it to
  /// a corresponding list of Facts and Locations
  List<dynamic> convertOrderedLocationsToLocations(
      List<OrderedTourLocation> orderedLocations) {
    List<Fact> facts = [];
    List<Location> locations = [];

    for (int i = 0; i < orderedLocations.length; i++) {
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

  /// Sets the tracker as active
  void activateTracker() async {
    String url = "https://wijha-417.ew.r.appspot.com/tour/tracker/activate";
    var response = await Dio().post(url,
        data: {"tracker": this.toJson()},
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));
  }
}
