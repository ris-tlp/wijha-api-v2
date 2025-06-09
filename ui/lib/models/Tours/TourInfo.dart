import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/models/Tours/Category.dart';

WCategory adventure = WCategory(title: adventureStr, icon: adventureIcon);
WCategory beach = WCategory(title: beachStr, icon: beachIcon);
WCategory cruise = WCategory(title: cruiseStr, icon: cruiseIcon);
WCategory historical = WCategory(title: historicalStr, icon: historicalIcon);
WCategory museum = WCategory(title: museumStr, icon: museumIcon);
WCategory nature = WCategory(title: natureStr, icon: natureIcon);
WCategory shopping = WCategory(title: shoppingStr, icon: shoppingIcon);

TourInclude transport =
    TourInclude(item: 'Transport', icon: 'assets/icons/transport.svg');
TourInclude meal =
    TourInclude(item: 'Meal', icon: 'assets/icons/transport.svg');
TourInclude tickets =
    TourInclude(item: 'Tickets', icon: 'assets/icons/transport.svg');
TourInclude snacks =
    TourInclude(item: 'Snacks', icon: 'assets/icons/snacks.svg');
TourInclude souvenir =
    TourInclude(item: 'Souvenir', icon: 'assets/icons/gift.svg');
TourInclude photoshoot =
    TourInclude(item: 'Photoshoot', icon: 'assets/icons/camera.svg');

List<WCategory> categories = [
  adventure,
  beach,
  cruise,
  historical,
  museum,
  nature,
  shopping,
];
DateTime t = DateTime.now();

class TourInfo {
  var name;
  var description;
  var tourCapacity;
  var locationFact;
  var locationNumber;
  var image;
  late String date;

// late String coordinates;
  late String coordinates;

//additional
  var price;
  late String time;
  late String tag;

  TourInfo(name, description, locationFact, locationNumber, image, coordinates,
      price, date, time, tag);

  TourInfo.empty();

  set setName(name) => this.name = name;

  set setDescription(description) => this.description = description;

  set setTourCapacity(tourCapacity) => this.tourCapacity = tourCapacity;

  set setLocationFact(locationFact) => this.locationFact = locationFact;

  set setLocationNumber(locationNumber) => this.locationNumber = locationNumber;

  set setImage(image) => this.image = image;

// set setCoordinates(coordinates) => this.coordinates = coordinates;
  set setPrice(price) => this.price = price;

  set setDate(date) => this.date = date;

  set setTime(time) => this.time = time;

  set setTag(tag) => this.tag = tag;

  set setCoordinates(coordinates) => this.coordinates = coordinates;

  createCustomTour(XFile image) async {
    print("OGGLEBOGGLE");
  }

  uploadImageBucket(XFile image) async {
// Takes a file object uploaded from a users gallery and uploads it to cloud storage
// Returns a URL of the uploaded image

    late String image_url;
    String image_name = image.name;
    String url = "https://wijha-417.ew.r.appspot.com/upload-image";
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var encoded_image = base64.encode(await File(image.path).readAsBytes());
    request.fields["name"] = this.name;
    request.fields["description"] = this.description;
    request.fields["capacity"] = this.tourCapacity;
    request.fields["numOfLocations"] = this.locationNumber;
    request.fields["image"] = this.image;
    request.fields["tourDate"] = this.date;
    request.fields["price"] = this.price;
    request.files.add(http.MultipartFile.fromString("image", encoded_image));

    print(request);

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    image_url = jsonDecode(responseString)["URL"];

    return image_url;
  }
}
// Map<String, Object> toJson()=>{
//   'id':this.id,
// };
// static Tour fromJson (Map<String, Object> myMap) => Tour(id: myMap['id'] as int, capacity: myMap['capacity'] as int, title: myMap['title'] as String, price: myMap['price'] as double, imgs: myMap['imgs'] as List<String>, guide: myMap['guide'] as String, destenations: myMap['destenations'] as List<String>, categories: myMap['categories'] as List<WCategory>, description: myMap['description'] as String, rating: myMap['rating'] as double, city: City.fromJson(myMap['city']as Map<String, Object>), dateTime: myMap['dateTime'] as DateTime, included: myMap['included'] as List<TourInclud>);

