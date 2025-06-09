import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Locations/CustomLocation.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Users/Tourist.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:http/http.dart' as http;

import '../../data.dart';
import '../Locations/City.dart';

part 'Guide.g.dart';

@JsonSerializable()
class Guide implements User {
  String userName;
  String profilePicture;
  bool netImage;
  int travelPoints;
  double rating;
  String type = "guide";
  String about;
  String location;
  List<String> languages = ["Arabic", "English"];
  int reviews;

  /// number of reviews, should removed when connected to backend
  Guide({
    required this.userName,
    this.profilePicture = 'assets/logos/wijhaLogo.png',
    this.netImage = false,
    this.travelPoints = 0,
    this.rating = 5.0,
    this.about = 'This guide has no about',
    this.location = 'None',
    this.reviews = 3,
  });

  /// Creates a Guide Object from JSON formatted object
  factory Guide.fromJson(Map<String, dynamic> json) => _$GuideFromJson(json);

  /// Converts Guide object to JSON format
  Map<String, dynamic> toJson() => _$GuideToJson(this);

  /// Fetches all the inactive tours for the Tour Guide
  /// Takes care of displaying the tours within the TourHistory page
  // void fetchInactiveTours(String guideID) async {
  //   String url = "http://192.168.100.14:8080/tour/inactive/$guideID";
  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     Iterable r = json.decode(response.body);
  //     List<Tour> tours =
  //         List<Tour>.from(r.map((model) => Tour.fromJson(model)));

  //     inspect(tours);
  //     // inspect(Tour.fromJson(response.body));
  //     // return null;
  //   } else {
  //     throw Exception("Failed to load.");
  //   }
  // }

  /// Reviews should be the total of all reviews across all tours
  int getTotalReviews() {
    return reviews;
  }

  /// Add EXP points to guide
  void addPoints(int points) {
    this.travelPoints += points;
  }

  List<Tour> tourList = [
    // Tour(
    //   title: 'The Amazing Tour',
    //   price: 1000,
    //   images: [
    //     'https://www.arabnews.com/sites/default/files/2018/08/05/1273581-806204011.jpg',
    //     'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2020/02/12/1968706-486009869.jpg?itok=xUNp4jvC',
    //   ],
    //   guide: 'guide',
    //   destinations: tourLocationData + tourLocationData + tourLocationData,
    //   facts: tourFactData + tourFactData + tourFactData,
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
    //   title: 'AlULA Tour',
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
  ]; // Tours provided

  List<Tour> tourHistoryList = [
    // Tour(
    //   title: 'Past The Amazing Tour',
    //   price: 1000,
    //   images: [
    //     'https://www.arabnews.com/sites/default/files/2018/08/05/1273581-806204011.jpg',
    //     'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2020/02/12/1968706-486009869.jpg?itok=xUNp4jvC',
    //   ],
    //   guide: 'guide',
    //   destinations: tourLocationData + tourLocationData,
    //   facts: tourFactData + tourFactData,
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
  ]; // To

  List<CustomLocation> customLocations = [
    // CustomLocation('custom Riyadh Season', 'Riyadh is fire.', 'lol', 3, 'assets/images/ALULA.jpg', ''),
    CustomLocation(
        name: 'custom Riyadh Season',
        description: 'Riyadh is fire.',
        locationFact: 'lol',
        locationNumber: 3,
        image: 'assets/images/ALULA.jpg',
        coordinates: '5.13252, 3.31616')
    // Location(
    //     name: 'custom Burj Al - Riyadh',
    //     description: 'I have never been to Hasa. Is this enough?',
    //     imageUrl: 'assets/images/hasa.jpg'),
    // Location(
    //     name: "custom Dannah McDonald's",
    //     description:
    //     'The city of Khobar has a description that should be quite nice.',
    //     imageUrl: 'assets/images/khobar.jpg'),
  ];

  final List<Location> locations = [
    Location(
        name: 'Riyadh Season',
        description: 'Riyadh is fire.',
        city: 'Riyadh',
        province: 'Riyadh',
        imageUrl: 'assets/images/ALULA.jpg'),
    Location(
        name: 'Burj Al - Riyadh',
        city: 'Riyadh',
        province: 'Riyadh',
        description: 'I have never been to Hasa. Is this enough?',
        imageUrl: 'assets/images/hasa.jpg'),
    Location(
        name: "Dannah McDonald's",
        description:
            'The city of Khobar has a description that should be quite nice.',
        city: 'Dharhan',
        province: 'Eastern Province',
        imageUrl: 'assets/images/khobar.jpg'),
  ];

  @override
  getLevel() {
    return (travelPoints ~/ 100).toString();
  }

  getProgress() {
    return (travelPoints / 100) * 100 ~/ 1;
  }
}
