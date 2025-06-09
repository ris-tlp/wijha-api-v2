import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Locations/OrderedTourLocation.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Tours/TourTracker.dart';
import 'User.dart';
import 'dart:io';

part 'Tourist.g.dart';

@JsonSerializable()
class Tourist implements User {
  String userName;
  String profilePicture;
  bool netImage;
  int travelPoints;
  double rating;
  String type = "tourist";
  bool inTour = false;
  Tour? activeTour;
  String location;

  Tourist({
    required this.userName,
    this.profilePicture = 'assets/logos/wijhaLogo.png',
    this.netImage = false,
    this.travelPoints = 0,
    this.rating = 5.0,
    this.location = 'None',
  });

  factory Tourist.fromJson(Map<String, dynamic> json) =>
      _$TouristFromJson(json);

  Map<String, dynamic> toJson() => _$TouristToJson(this);

  void markTouristAttendance(String tourID) async {
    String url = "https://wijha-417.ew.r.appspot.com/tour/attendance";

    var response = await Dio().post(url,
        data: {"user": this.toJson(), "tour": tourID},
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));
  }

  Future<List<Tour>> fetchTouristInactiveTours(
      {active: false, history: false}) async {
    String url = "https://wijha-417.ew.r.appspot.com/tour/tourist";

    var response = await Dio().post(url,
        data: {"tourist": this.toJson(), "active": active, "history": history},
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

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

  /// lmao
  Future<bool> checkIfTrackerActive() async {
    String url = "https://wijha-417.ew.r.appspot.com/tour/tracker/active/check";
    var response = await Dio().post(url,
        data: {"user": this.toJson()},
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    print(response.data);

    return response.data;
  }

  /// Fetches the active tour tracker
  /// Each tourist can only have one tour tracker active at at time
  Future<dynamic> fetchActiveTourTracker() async {
    String url =
        "https://wijha-417.ew.r.appspot.com/tour/tracker/tourist/active";
    var response = await Dio().post(url,
        data: {"user": this.toJson()},
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    if (response.data is bool) {
      return false; // No active tour tracker
    } else {
      TourTracker tracker = TourTracker.fromJson(response.data);

      List<dynamic> unmergedOrderedLocations = tracker.tour
          .convertOrderedLocationsToLocations(tracker.tour.orderedLocations);

      tracker.tour.destinations = unmergedOrderedLocations[0];
      tracker.tour.facts = unmergedOrderedLocations[1];

      return tracker;
    }
  }

  void setInTour() {
    if (!inTour) inTour = !inTour;
  }

  void setOutOfTour() {
    if (inTour) inTour = !inTour;
  }

  void setActiveTour(Tour tour) {
    activeTour = tour;
  }

  Tour? getActiveTour() {
    return activeTour;
  }

  void removeActiveTour() {
    activeTour = null;
  }

  bool isInTour() {
    return inTour;
  }

  void addPoints(int points) {
    this.travelPoints += points;
  }

  final List<Tour> tourList = [
    // Tour(
    //   title: 'Scuba diving in jeddah',
    //   price: 800,
    //   images: [
    //     'https://scth.scene7.com/is/image/scth/card-01-387:crop-1160x650?defaultImage=card-01-387&wid=1023&hei=573',
    //     'https://scth.scene7.com/is/image/scth/card-02-369:crop-1160x650?defaultImage=card-02-369&wid=1023&hei=573',
    //   ],
    //   guide: guide,
    //   destinations: jeddahScubaDest,
    //   facts: jeddahScubaFact,
    //   description:
    //       'This tour is very safe, very fun, and is an exclusive trip to Jeddah. At least 4 people enter a cage around which sharks swim and roam, accompanied by professional experts and divers, and perhaps for the first time in your life, you will observe this unique predator closely, and witness a few moments in its interesting life.',
    //   rating: 4.4,
    //   categories: [adventure, beach],
    //   city: cityList[3],
    //   dateTime: t.add(Duration(days: 14)),
    //   capacity: 4,
    //   included: [transport, snacks, photoshoot],
    // ),
    // Tour(
    //   title: 'Ancient jeddah',
    //   price: 1000,
    //   images: [
    //     'https://i1.wp.com/www.agoda.com/wp-content/uploads/2019/05/Things-to-do-in-Jeddah-Saudi-Arabia-Al-Balad.jpg',
    //     'https://welcomesaudi.com/uploads/0000/1/2021/07/23/17-nassif-house-museum-jeddah-makkah-province.jpg',
    //     'https://www.visitsaudi.com/content/dam/saudi-tourism/media/do/1920x1080/00hero_Jeddah_Museum-of-Abdul-Raoof-Hasan-Khalil-2.jpg'
    //   ],
    //   guide: guide,
    //   destinations: jeddahAncientDest,
    //   facts: jeddahAncientFact,
    //   description:
    //       "This tour includes a visit to one of Saudi Arabia's most historic centers, 'Jeddah al-balad', where you will be able to see how old people live, as well as a visit to a rich people's house, the Nassif House, which was once the residence of a wealthy merchant family. In addition, you will have the opportunity to visit Tayebat City, which houses an extraordinary range of exhibits and collections that bring pre-Islamic and Islamic history to life in 300 rooms and 12 buildings.",
    //   rating: 4.4,
    //   categories: [historical, museum],
    //   city: cityList[3],
    //   dateTime: t.add(Duration(days: 3)),
    //   capacity: 20,
    //   included: [transport, snacks, photoshoot],
    // ),
    // Tour(
    //   title: 'Al wahba Trip (Maqla Tmeah)',
    //   price: 1800,
    //   images: [
    //     'https://www.halayalla.com/_next/image?url=https%3A%2F%2Fhalayallaimages-new.s3.me-south-1.amazonaws.com%2Fdmc%2Fvenue-images%2Fdmc_venue_622f1b87c2467.jpeg&w=3840&q=60',
    //   ],
    //   guide: guide,
    //   destinations: taifTripDest,
    //   facts: taifTripFact,
    //   description:
    //       'take a trip into the desert with a friend or a group and travel into the dusty plateaus. Enjoy breathtaking views of the mountain region as you make your way to the site of the volcanic crater.',
    //   rating: 3.5,
    //   categories: [adventure, nature],
    //   city: cityList[2],
    //   dateTime: t.add(Duration(days: 5)),
    //   capacity: 10,
    //   included: [transport, snacks, photoshoot],
    // ),
    // Tour(
    //   title: 'Historical Shaqra Trip',
    //   price: 700,
    //   images: [
    //     'https://1.bp.blogspot.com/-SRlAiX9HlgU/YKjpJygwuWI/AAAAAAAAk7I/i37VgXZBo_YGRSIHKvehfFzyKfTN_9XTACLcBGAsYHQ/s16000/Shaqra_Historical_Village2.jpg',
    //     'https://1.bp.blogspot.com/-Uu84Zo-D-Rk/YKjpGjhioNI/AAAAAAAAk7A/X4mcEp4dEksJ7FgZ9K_gwnjVh_dnaFuxACLcBGAsYHQ/s16000/Shaqra_Historical_Village1.jpg'
    //   ],
    //   guide: guide,
    //   destinations: RiyadhAncientDest,
    //   facts: RiyadhAncientFact,
    //   description:
    //       "The journey to Historical Shaqra is a journey of interaction between the past and the present. Shaqra heritage town is the recreation of the ancient city, which is estimated to be over 1,500 years old; and it has been rebuilt as it was before. During this trip, visitors can pass through the Qasab Salt Fields, where they can see groundwater loaded with salt being extracted from the ground, and then the salt being extracted from water as it was done hundreds of years ago. Then, go to Shaqra heritage town where visitors could walk down the streets of the old city and see the old-fashioned architecture and the way the buildings are joined together. Visitors could visit its mosques, councils, old markets, museums, and Hlewa Heritage Market. After that, visitors could go to the old city of Ushaiger, where on the way, the old airport could be seen. Visitors can walk between the alleys of old houses that were rebuilt in Ushaiger village, visit the private museums, and then visit the park, where they can have a panoramic view of the Ushaiger heritage village, its farms and the modern city of Ushaiger.",
    //   rating: 4.1,
    //   categories: [historical, museum],
    //   city: cityList[0],
    //   dateTime: t.add(Duration(days: 3)),
    //   capacity: 20,
    //   included: [transport, snacks, photoshoot],
    // ),
  ]; // Tours registered in

  final List<Tour> tourHistoryList = [
    // Tour(
    //   title: 'Past The Amazing Tour',
    //   price: 1000,
    //   images: [
    //     'https://www.arabnews.com/sites/default/files/2018/08/05/1273581-806204011.jpg',
    //     'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2020/02/12/1968706-486009869.jpg?itok=xUNp4jvC',
    //   ],
    //   guide: 'guide',
    //   destinations: tourLocationData,
    //   facts: tourFactData,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sit amet est a tellus tristique venenatis. Aliquam diam nulla, feugiat nec lacinia quis, semper eu leo. Phasellus ut nisl vitae erat dapibus aliquet ut vitae risus. Vestibulum tempus eget velit eu posuere. Quisque eleifend porttitor consequat. Proin a tellus ut velit elementum commodo et a lorem. Sed accumsan eu turpis id hendrerit.',
    //   rating: 4.4,
    //   categories: [adventure, nature, historical, beach],
    //   city: City(
    //       name: 'Khobar',
    //       description: '',
    //       imageUrl: '',
    //       province: 'Eastern province'),
    //   dateTime: DateTime.now(),
    //   capacity: 8,
    //   included: [transport, snacks, photoshoot, souvenir],
    // ),
    // Tour(
    //   title: 'Past AlULA Tour',
    //   price: 999.9,
    //   images: [
    //     'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2020/02/12/1968706-486009869.jpg?itok=xUNp4jvC',
    //   ],
    //   guide: 'guide',
    //   destinations: tourLocationData,
    //   facts: tourFactData,
    //   description: 'description',
    //   rating: 4.4,
    //   categories: [museum, historical],
    //   city: City(
    //       name: 'Khobar',
    //       description:
    //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sit amet est a tellus tristique venenatis. Aliquam diam nulla, feugiat nec lacinia quis, semper eu leo. Phasellus ut nisl vitae erat dapibus aliquet ut vitae risus. Vestibulum tempus eget velit eu posuere. Quisque eleifend porttitor consequat. Proin a tellus ut velit elementum commodo et a lorem. Sed accumsan eu turpis id hendrerit.',
    //       imageUrl: '',
    //       province: 'Eastern province'),
    //   dateTime: DateTime.now(),
    //   capacity: 10,
    //   included: [transport, tickets, meal],
    // ),
  ];

  @override
  getLevel() {
    return (travelPoints ~/ 100).toString();
  }

  getProgress() {
    return (travelPoints / 100) * 100 ~/ 1;
  }

  bool hasActiveTour() {
    if (activeTour != null)
      return true;
    else
      return false;
  }
}
