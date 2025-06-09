import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wijha/models/Blogs/BlogPost.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/models/Forums/Subforum.dart';
import 'package:wijha/models/Forums/tempPosts.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/models/Tours/Review.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/widgets/constants.dart';
import 'models/Locations/Province.dart';
import 'models/Tours/Category.dart';
import 'models/Users/Guide.dart';
import 'models/Users/Tourist.dart';
import 'models/Users/User.dart';

User user = User(userName: 'Uninitialized'); // Not for use
Tourist loginTourist = Tourist(
    userName: 'Mowfaq Wali',
    profilePicture: "https://i.ibb.co/QD7HnMc/myphoto.jpg",
    netImage: true,
    travelPoints: 50);
Guide loginGuide = Guide(userName: 'Khalifah Alhomely');

List<ForumPost> posts = TempPosts().postList + TempPosts().jeddahList;
List<ForumPost> jeddahPosts = TempPosts().jeddahList;
List<ForumPost> riyadhPosts = TempPosts().postList;

Guide guide = Guide(
    userName: 'Ahmed',
    rating: 4,
    about:
        "My name is Ahmed.I am living in Makkah. I have been working at the Holy Masjid Al Haram since 2007, and I have experienced the most touristic and local places in my city. I can show you Makkah! We can visit tourist places; I know every place which can bring out FUN here! So let's start the trip together!",
    location: "Makkah Province");
Guide guide2 = Guide(
    userName: 'Mohammed',
    rating: 4,
    about:
        "My name is Mohammed. I am living in Riyadh. I want to show my city to people coming here from around the world.",
    location: "Riyadh Province");

Tourist tourist = Tourist(
    userName: 'Mohammed',
    rating: 3,
    profilePicture:
        "https://images.unsplash.com/photo-1520434087499-0fa48ffb40c9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGUlMjBzYXVkaSUyMGFyYmlhfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60",
    netImage: true,
    travelPoints: 50);

Tourist tourist2 = Tourist(
    userName: 'Ahmed',
    rating: 4,
    profilePicture:
        "https://images.unsplash.com/profile-1531207015949-59eb004bc231?dpr=2&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff",
    netImage: true,
    travelPoints: 100);

Tourist tourist3 = Tourist(
  userName: 'Hadi',
  rating: 5,
  travelPoints: 30,
);

WCategory adventure = WCategory(title: adventureStr, icon: adventureIcon);
WCategory beach = WCategory(title: beachStr, icon: beachIcon);
WCategory cruise = WCategory(title: cruiseStr, icon: cruiseIcon);
WCategory historical = WCategory(title: historicalStr, icon: historicalIcon);
WCategory museum = WCategory(title: museumStr, icon: museumIcon);
WCategory nature = WCategory(title: natureStr, icon: natureIcon);
WCategory shopping = WCategory(title: shoppingStr, icon: shoppingIcon);

TourInclude transport =
    TourInclude(item: 'Transport', icon: 'assets/icons/van.svg');
TourInclude meal = TourInclude(item: 'Meal', icon: 'assets/icons/meal.svg');
TourInclude tickets =
    TourInclude(item: 'Tickets', icon: 'assets/icons/ticket.svg');
TourInclude snacks =
    TourInclude(item: 'Snacks', icon: 'assets/icons/snack.svg');
TourInclude souvenir =
    TourInclude(item: 'Souvenir', icon: 'assets/icons/gift.svg');
TourInclude photoshoot =
    TourInclude(item: 'Photoshoot', icon: 'assets/icons/camera.svg');

List<TourInclude> include = [
  transport,
  meal,
  tickets,
  snacks,
  souvenir,
  photoshoot,
];

List<WCategory> categories = [
  adventure,
  beach,
  cruise,
  historical,
  museum,
  nature,
  shopping,
];

List<WCategory> categoriesPicked = [];
List<TourInclude> included = [];
int tourid = 0;
int tournumber() {
  int temp = tourid;
  tourid += 1;
  return temp;
}

List<Province> provinceData = [
  Province(
      name: 'Riyadh',
      description:
          'The capital governorate of the province is the Riyadh Governorate and it is named after the capital of the kingdom, Riyadh, which is the most populous city in the region and the kingdom, with a little less than two-thirds of the population of the region residing within the city. Located in the geographic center of the country. it is the second-largest region by both area and population',
      imageUrl: 'assets/images/Riyadh.jpg'),
  Province(
      name: 'Makkah',
      description:
          'The third-largest province by area and the most populous with a population of. It is located in the historic Hejaz region, and has an extended coastline on the Red Sea. Its capital is Mecca, the holiest city in Islam, and its largest city is Jeddah, which is Saudi Arabia main port city',
      imageUrl: 'assets/images/makkah.webp'),
  Province(
      name: 'Eastern',
      description:
          'The largest province by area and the third most populous after the Riyadh Province and the Mecca Province. More than a third of the population is concentrated in the Dammam metropolitan area',
      imageUrl: 'assets/images/eastern.jpg'),
  Province(
      name: 'Madinah',
      description:
          'The second holiest city in Islam, located on the country western side, along the Red Sea coast. The regional capital is Medina,',
      imageUrl: 'assets/images/madinah.jpg'),
  Province(
      name: 'Al-Baha',
      description:
          'Located in the southwestern part of the Hejazi region. Its capital is Al Bahah. The region includes Al-Baḥah City, Al-Mikhwah and Baljorashi',
      imageUrl: 'assets/images/al-baha.jpg'),
  Province(
      name: 'Al-Jawf',
      description:
          'Located in the north of the country, containing its only international border with Jordan to the west. It is one of the earliest inhabited regions of Arabian Peninsula, with evidence of human habitation dating back to the Stone Age and the Acheulean tool culture',
      imageUrl: 'assets/images/al-jouf.jpg'),
  Province(
      name: 'Northern Borders',
      description:
          "The least populated region of Saudi Arabia. It is located in the north of the country, bordering Iraq and Jordan. The capital is Ar'ar and the region is sub-divided into three governates Rafha, Turayf and Ar'ar",
      imageUrl: 'assets/images/northern.png'),
  Province(
      name: 'Qassim',
      description:
          'Located at the heart of the country near the geographic center of the Arabian Peninsula. Located at the heart of the country near the geographic center of the Arabian Peninsula. Al-Qassim is the richest region per capita in Saudi Arabia. It is the seventh most populated region in the country after Jizan and the fifth most densely populated. It has more than 400 cities, towns, villages, and Bedouin settlements, ten of which are recognized as governorates. Its capital city is Buraydah',
      imageUrl: 'assets/images/qassim.jpg'),
  Province(
      name: "Ha'il",
      description:
          "The eighth-largest province by area and the ninth-largest by population. The province accounts for roughly 2% of the population of the country and is named for its largest city, Ha'il. Other populous cities in the province include al-Ghazalah, Shinan and Baq'aa. The region is famous for the twin mountain ranges of 'Aja and Salma, and for being the homeland of historic symbol of curiosity and generosity, Hatim al-Ta`i. The province is popular for hosting the geographically and historically important twin mountain ranges of 'Aja and Salma, which are now areas protected by the Saudi Wildlife Authority. In addition, multiple rock art sites can be found in the province, two sites of which have been added to the UNESCO World Cultural Heritage Site List; Jabal Umm Sinman near Jubbah and Jabal al-Manjur",
      imageUrl: 'assets/images/hail.jpg'),
  Province(
      name: 'Tabuk',
      description:
          "Located along the north-west coast of the country, facing Egypt across the Red Sea. Its capital is Tabuk. the province has received substantial media attention due to the Saudi government's futuristic Neom City project in the province.",
      imageUrl: 'assets/images/tabuk.jpg'),
  Province(
      name: 'Asir',
      description:
          "Located in the southwest of the country that is named after the ʿAsīr tribe. It is surrounded by Mecca Province to the north and west, Al-Bahah Province to the northwest, Riyadh Province to the northeast, Jazan Province to the south, and Najran Province to the southeast. ʿAsir also shares a short border with the Saada Governorate of Yemen to the south. The capital of the ʿAsir Region is Abha. Other towns include Khamis Mushait, Bisha and Bareq.",
      imageUrl: 'assets/images/asir.jpg'),
  Province(
      name: 'Jazan',
      description:
          "The second smallest (after Al Bahah) region of Saudi Arabia. The region has the highest population density in the Kingdom. The capital is the city of Jazan/The region includes over 100 islands in the Red Sea. Jazan Economic City is a mega project that is planned to boost the economy of the region and make it part of the Saudi economic growth.[3] The Farasan Islands, Saudi Arabia's first conservation protected area, is home to migratory birds from Europe in winter.",
      imageUrl: 'assets/images/jazan.jpg'),
  Province(
      name: 'Najran',
      description:
          'Located in the south of the country along the border with Yemen. Its capital is Najran.',
      imageUrl: 'assets/images/najran.jpg'),
];

List<City> cityList = [
  City(
      name: "Riyadh",
      description:
          "Riyadh is the capital of Saudi Arabia and one of the largest cities on the Arabian Peninsula. Located in the center of the an-Nafud desert, on the eastern part of the Najd plateau.",
      imageUrl: "assets/images/Riyadh.jpg",
      province: "Riyadh province",
      provinceId: 0),
  City(
    name: "Al majma'ah",
    description:
        "Al majma'ah is the capital of the Sudair region. The city has an area of 30,000 square kilometres",
    imageNet: true,
    imageUrl:
        'https://www.ootlah.com/wp-content/uploads/2021/03/ruined-traditional-mudbrick-houses-near-munikh-castle-archeological-site-al-majmaah-saudi-arabia-arab-mud-brick-architecture-134461609.jpg',
    province: 'Riyadh province',
    provinceId: 0,
  ),
  City(
    name: "Al zulfi",
    description:
        'Al Zulfi is in the East of Al-Qassim Province and at the heart of the historical region of Najd',
    imageNet: true,
    imageUrl: 'https://www.urtrips.com/wp-content/uploads/2019/01/Zulfi-10.jpg',
    province: 'Riyadh province',
    provinceId: 0,
  ),
  City(
    name: 'Taif',
    description:
        'Taif is a city and governorate in the Makkah Province of Saudi Arabia. Located in the slopes of the Hejaz Mountains, which themselves are part of the Sarawat Mountains.',
    imageNet: true,
    imageUrl: 'https://welcomesaudi.com/uploads/0000/1/2021/07/23/taif.jpg',
    province: 'Makkah province',
    provinceId: 1,
  ),
  City(
    name: 'Jeddah',
    description:
        'Jeddah is the largest city in Makkah Province, the largest city in Hejaz.',
    imageNet: true,
    imageUrl: 'https://i.imgur.com/2rA2mj1.png',
    province: 'Makkah province',
    provinceId: 1,
  ),
  City(
    name: 'Khobar',
    description:
        'Khobar is a city and governorate in the Eastern Province of the Kingdom of Saudi Arabia, situated on the coast of the Persian Gulf',
    imageNet: true,
    imageUrl:
        'https://www.timeoutriyadh.com/cloud/timeoutriyadh/2021/11/02/Khobar-saudi-arabia3-1024x768.jpg',
    province: 'Eastern province',
    provinceId: 2,
  ),
  City(
    name: 'Hofuf',
    description:
        'Hofuf is the major urban city in the Al-Ahsa Oasis in the Eastern Province of Saudi Arabia',
    imageNet: true,
    imageUrl:
        'https://www.beyondmydoor.com/wp-content/uploads/2016/01/IMG402.jpg',
    province: 'Eastern province',
    provinceId: 2,
  ),
  City(
    name: "Madain saleh",
    description:
        'Madain Saleh is the most iconic historical site of the Kingdom of Saudi Arabia and the first to be listed as a UNESCO Word Heritage',
    imageNet: true,
    imageUrl:
        'https://lp-cms-production.imgix.net/2019-06/4f771f594c8138b92a419bf48f0d1152-madain-saleh.jpg?auto=compress&crop=center&fit=crop&format=auto&h=832&w=1920',
    province: 'Madinah province',
    provinceId: 3,
  ),
  City(
    name: "Yanbu",
    description:
        'Yanbu is a city in the Al Madinah Province of western Saudi Arabia. It is approximately 300 kilometers northwest of Jeddah',
    imageNet: true,
    imageUrl: 'https://joygeneroso.files.wordpress.com/2019/03/yff2019-19.jpg',
    province: 'Madinah province',
    provinceId: 3,
  ),
  City(
      name: "Madinah",
      description:
          "Madinah is the second-holiest city in Islam and the capital of the Medina Province of Saudi Arabia.",
      imageUrl: "assets/images/madinah.jpg",
      province: "Madinah province",
      provinceId: 3),
];

// Tour t1 = Tour(
//   title: 'The Amazing Tour',
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
//   city: cityList[4],
//   dateTime: t,
//   capacity: 8,
//   included: [transport, snacks, photoshoot, souvenir],
// );
DateTime t = DateTime.now();

// Tour t2 = Tour(
//   title: 'AlULA Tour',
//   price: 999.9,
//   images: [
//     'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2020/02/12/1968706-486009869.jpg?itok=xUNp4jvC',
//   ],
//   guide: 'guide',
//   destinations: tourLocationData + tourLocationData,
//   facts: tourFactData + tourFactData,
//   description: 'description',
//   rating: 4.4,
//   categories: [museum, historical],
//   city: cityList[8],
//   dateTime: t,
//   capacity: 10,
//   included: [transport, tickets, meal],
// );

Tour t3 = Tour(
  title: 'Scuba diving in jeddah',
  id: "0",
  price: 800,
  images: [
    'https://scth.scene7.com/is/image/scth/card-01-387:crop-1160x650?defaultImage=card-01-387&wid=1023&hei=573',
    'https://scth.scene7.com/is/image/scth/card-02-369:crop-1160x650?defaultImage=card-02-369&wid=1023&hei=573',
  ],
  guide: guide,
  destinations: jeddahScubaDest,
  facts: jeddahScubaFact,
  description:
      'This tour is very safe, very fun, and is an exclusive trip to Jeddah. At least 4 people enter a cage around which sharks swim and roam, accompanied by professional experts and divers, and perhaps for the first time in your life, you will observe this unique predator closely, and witness a few moments in its interesting life.',
  rating: 0,
  categories: [adventure, beach],
  city: cityList[4],
  dateTime: t.add(Duration(days: 14)),
  capacity: 4,
  included: [transport, snacks, photoshoot],
);

List<Tour> getTours() {
  Tour t4 = Tour(
    title: 'Al wahba Trip (Maqla Tmeah)',
    id: "0",
    price: 1800,
    images: [
      'https://www.halayalla.com/_next/image?url=https%3A%2F%2Fhalayallaimages-new.s3.me-south-1.amazonaws.com%2Fdmc%2Fvenue-images%2Fdmc_venue_622f1b87c2467.jpeg&w=3840&q=60',
    ],
    guide: guide,
    destinations: taifTripDest,
    facts: taifTripFact,
    description:
        'take a trip into the desert with a friend or a group and travel into the dusty plateaus. Enjoy breathtaking views of the mountain region as you make your way to the site of the volcanic crater.',
    rating: 0,
    categories: [adventure, nature],
    city: cityList[3],
    dateTime: t.add(Duration(days: 5, hours: 19, minutes: 15)),
    capacity: 10,
    included: [transport, snacks, photoshoot],
  );
  t4.addReview(Review(rating: 4, user: tourist, comment: "Amazing tour!!"));
  Tour t5 = Tour(
    title: 'Ancient jeddah',
    id: "0",
    price: 1000,
    images: [
      'https://i1.wp.com/www.agoda.com/wp-content/uploads/2019/05/Things-to-do-in-Jeddah-Saudi-Arabia-Al-Balad.jpg',
      'https://welcomesaudi.com/uploads/0000/1/2021/07/23/17-nassif-house-museum-jeddah-makkah-province.jpg',
      'https://www.visitsaudi.com/content/dam/saudi-tourism/media/do/1920x1080/00hero_Jeddah_Museum-of-Abdul-Raoof-Hasan-Khalil-2.jpg'
    ],
    guide: guide,
    destinations: jeddahAncientDest,
    facts: jeddahAncientFact,
    description:
        "This tour includes a visit to one of Saudi Arabia's most historic centers, 'Jeddah al-balad', where you will be able to see how old people live, as well as a visit to a rich people's house, the Nassif House, which was once the residence of a wealthy merchant family. In addition, you will have the opportunity to visit Tayebat City, which houses an extraordinary range of exhibits and collections that bring pre-Islamic and Islamic history to life in 300 rooms and 12 buildings.",
    rating: 0,
    categories: [historical, museum],
    city: cityList[4],
    dateTime: t.add(Duration(days: 3, hours: 20, minutes: 10)),
    capacity: 20,
    included: [transport, snacks, photoshoot],
  );
  t5.addReview(
      Review(rating: 3.5, user: tourist2, comment: "Tour is good overall"));
  t5.addAttendance(loginTourist);

  Tour t6 = Tour(
    title: 'Historical Shaqra Trip',
    id: "0",
    price: 700,
    images: [
      'https://1.bp.blogspot.com/-SRlAiX9HlgU/YKjpJygwuWI/AAAAAAAAk7I/i37VgXZBo_YGRSIHKvehfFzyKfTN_9XTACLcBGAsYHQ/s16000/Shaqra_Historical_Village2.jpg',
      'https://1.bp.blogspot.com/-Uu84Zo-D-Rk/YKjpGjhioNI/AAAAAAAAk7A/X4mcEp4dEksJ7FgZ9K_gwnjVh_dnaFuxACLcBGAsYHQ/s16000/Shaqra_Historical_Village1.jpg'
    ],
    guide: guide2,
    destinations: RiyadhAncientDest,
    facts: RiyadhAncientFact,
    description:
        "The journey to Historical Shaqra is a journey of interaction between the past and the present. Shaqra heritage town is the recreation of the ancient city, which is estimated to be over 1,500 years old; and it has been rebuilt as it was before. During this trip, visitors can pass through the Qasab Salt Fields, where they can see groundwater loaded with salt being extracted from the ground, and then the salt being extracted from water as it was done hundreds of years ago. Then, go to Shaqra heritage town where visitors could walk down the streets of the old city and see the old-fashioned architecture and the way the buildings are joined together. Visitors could visit its mosques, councils, old markets, museums, and Hlewa Heritage Market. After that, visitors could go to the old city of Ushaiger, where on the way, the old airport could be seen. Visitors can walk between the alleys of old houses that were rebuilt in Ushaiger village, visit the private museums, and then visit the park, where they can have a panoramic view of the Ushaiger heritage village, its farms and the modern city of Ushaiger.",
    rating: 0,
    categories: [historical, museum],
    city: cityList[0],
    dateTime: t.add(Duration(days: 3, hours: 17, minutes: 00)),
    capacity: 20,
    included: [transport, snacks, photoshoot],
  );
  t6.addReview(Review(
    rating: 3,
    user: tourist2,
  ));
  return [t4, t5, t6];
}

List<Tour> toursData = getTours();

Tour createDemo = t3;

// List<Location> tourLocationData = [
//   // Location(
//   //     name: 'Riyadh Season',
//   //     description: 'Riyadh is fire.',
//   //     city: 'Riyadh',
//   //     province: 'Riyadh',
//   //     imageUrl: 'assets/images/ALULA.jpg'),
//   // Location(
//   //     name: 'Burj Al - Riyadh',
//   //     city: 'Riyadh',
//   //     province: 'Riyadh',
//   //     description: 'I have never been to Hasa. Is this enough?',
//   //     imageUrl: 'assets/images/hasa.jpg'),
//   // Location(
//   //     name: "Dannah McDonald's",
//   //     description:
//   //         'The city of Khobar has a description that should be quite nice.',
//   //     city: 'Dharhan',
//   //     province: 'Eastern Province',
//   //     imageUrl: 'assets/images/khobar.jpg'),
//   Location(
//       name: "Sharm Obhur",
//       description:
//           'This is one of the largest urban residential projects in the Kingdom of Saudi Arabia. Situated north of Jeddah',
//       city: 'Jeddah',
//       province: 'Makkah Province',
//       imageNet: true,
//       imageUrl:
//           'https://scth.scene7.com/is/image/scth/card-03-262:crop-1160x650?defaultImage=card-03-262&wid=1023&hei=573'),
//   Location(
//       name: "Al Wahbah crater",
//       description:
//           " is a volcanic crater, which is about 250 kilometres (160 miles) away from Ta'if, on the western edge of the Harrat Kishb basalt plateau in the Hejazi region of Saudi Arabia",
//       city: 'Taif',
//       province: 'Makkah Province',
//       imageNet: true,
//       imageUrl:
//           'https://www.halayalla.com/_next/image?url=https%3A%2F%2Fhalayallaimages-new.s3.me-south-1.amazonaws.com%2Fdmc%2Fvenue-images%2Fdmc_venue_622f1b88edadc.jpeg&w=1080&q=60'),
//   Location(
//       name: 'Jeddah Al-balad',
//       description:
//           "the historic downtown area of Jeddah originally built in the 7th century, is a memorable experience. The area’s charm has been preserved through careful restoration of the striking townhouses and narrow streets. Come for the unique architecture, the colorful markets and enchanting atmosphere.",
//       imageNet: true,
//       imageUrl:
//           "https://scth.scene7.com/is/image/scth/NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3:crop-1920x1080?defaultImage=NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3&wid=1160&hei=652",
//       city: 'Jeddah',
//       province: 'Makkah'),
//   Location(
//       name: 'Naseef House',
//       description:
//           "This restored coral house was once the royal residence for King Abdul Aziz Ibn Saud, following his conquering of the city in 1925. Inside you can see ramps that were installed to allow camels to walk all the way up to the upper terrace and a beautiful neem tree at the entrance, once believed to be the only tree in Jeddah.",
//       imageNet: true,
//       imageUrl:
//           "https://scth.scene7.com/is/image/scth/26Oct_OldJeddah_4286%20x%202411-1:crop-1920x1080?defaultImage=26Oct_OldJeddah_4286%20x%202411-1&wid=1160&hei=652",
//       city: 'Jeddah',
//       province: 'Makkah'),
//   Location(
//       name: 'Tayebat City of Science and Knowledge',
//       description:
//           "The Tayebat City of Science and Knowledge is a must-see museum, housing an extraordinary range of exhibits and collections. Bringing pre-Islamic and Islamic history to life, the museum spans the House of Saudi Arabian Heritage, the House of Islamic Heritage, the House of International Heritage and the Public Heritage exhibition.",
//       imageNet: true,
//       imageUrl:
//           "https://scth.scene7.com/is/image/scth/26Oct_OldJeddah_4286%20x%202411-1:crop-1920x1080?defaultImage=26Oct_OldJeddah_4286%20x%202411-1&wid=1160&hei=652",
//       city: 'Jeddah',
//       province: 'Makkah')
// ];

// List<Fact> tourFactData = [
//   Fact(
//       content: 'The first fact is wowser, it is tough coming up with facts',
//       location: tourLocationData[0]),
//   Fact(
//       content: 'The second fact is my I do not have any facts',
//       location: tourLocationData[1]),
//   Fact(
//       content: 'The third fact is my brain is humongous',
//       location: tourLocationData[2]),
// ];

List<Location> jeddahScubaDest = [
  Location(
      name: 'Sharm Obhur',
      description:
          "Located in the middle north part of Jeddah, near the luxury resort of Bhadur, Sharm Obhur is one of Jeddah's best diving destinations. Be sure that you will not be alone diving, as you will have a bunch of cute-looking turtles next to you, and you will be greeted by lionfish and eels, and the deeper you swim, the more fish and unique species you will discover!",
      imageNet: true,
      imageUrl:
          "https://scth.scene7.com/is/image/scth/card-03-262:crop-1160x650?defaultImage=card-03-262&wid=1023&hei=573",
      city: 'Jeddah',
      province: 'Makkah')
];

List<Fact> jeddahScubaFact = [
  Fact(
      content:
          "One of the closest dive sites to Jeddah, offshore from the Bahadur Resort and where Blue Reef Divers has a base. The reef is excellent here and the experience feels like a boat dive, despite being a shore dive. You'll encounter eels, octopus, lionfish, clownfish, turtles, and, if you're really lucky, a rare bull shark.",
      location: locationsList[2]),
];

List<Location> taifTripDest = [
  Location(
      name: 'Al Wahbah Crater',
      description: "250 m (820 ft) deep and 2 kms in diameter volcanic crator.",
      imageNet: true,
      imageUrl:
          "https://www.halayalla.com/_next/image?url=https%3A%2F%2Fhalayallaimages-new.s3.me-south-1.amazonaws.com%2Fdmc%2Fvenue-images%2Fdmc_venue_622f1b88edadc.jpeg&w=1080&q=60",
      city: 'Taif',
      province: 'Makkah')
];

List<Fact> taifTripFact = [
  Fact(
      content:
          "It takes a person 45–60 minutes to go to the bottom of the crater. This crater is very slippery and it is hard for people to come up to the surface. To climb back up takes approx 60–90 minutes. It is so deep that if you throw a stone from the top, you will hear it hit the ground after 6 seconds. The bottom of the crater is covered with white sodium phosphate crystals.",
      location: locationsList[4]),
];

List<Location> locationsList = [
  Location(
      name: 'Jeddah Al-balad',
      description:
          "the historic downtown area of Jeddah originally built in the 7th century, is a memorable experience. The area’s charm has been preserved through careful restoration of the striking townhouses and narrow streets. Come for the unique architecture, the colorful markets and enchanting atmosphere.",
      imageNet: true,
      imageUrl:
          "https://scth.scene7.com/is/image/scth/NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3:crop-1920x1080?defaultImage=NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3&wid=1160&hei=652",
      city: 'Jeddah',
      cityId: 4,
      provinceId: 1,
      province: 'Makkah'),
  Location(
      name: 'Naseef House',
      description:
          "This restored coral house was once the royal residence for King Abdul Aziz Ibn Saud, following his conquering of the city in 1925. Inside you can see ramps that were installed to allow camels to walk all the way up to the upper terrace and a beautiful neem tree at the entrance, once believed to be the only tree in Jeddah.",
      imageNet: true,
      imageUrl:
          "https://scth.scene7.com/is/image/scth/26Oct_OldJeddah_4286%20x%202411-1:crop-1920x1080?defaultImage=26Oct_OldJeddah_4286%20x%202411-1&wid=1160&hei=652",
      city: 'Jeddah',
      cityId: 4,
      provinceId: 1,
      province: 'Makkah'),
  Location(
      name: 'Sharm Obhur',
      description:
          "Located in the middle north part of Jeddah, near the luxury resort of Bhadur, Sharm Obhur is one of Jeddah's best diving destinations. Be sure that you will not be alone diving, as you will have a bunch of cute-looking turtles next to you, and you will be greeted by lionfish and eels, and the deeper you swim, the more fish and unique species you will discover!",
      imageNet: true,
      imageUrl:
          "https://scth.scene7.com/is/image/scth/card-03-262:crop-1160x650?defaultImage=card-03-262&wid=1023&hei=573",
      city: 'Jeddah',
      cityId: 4,
      provinceId: 1,
      province: 'Makkah'),
  Location(
      name: 'Tayebat City of Science and Knowledge',
      description:
          "The Tayebat City of Science and Knowledge is a must-see museum, housing an extraordinary range of exhibits and collections. Bringing pre-Islamic and Islamic history to life, the museum spans the House of Saudi Arabian Heritage, the House of Islamic Heritage, the House of International Heritage and the Public Heritage exhibition.",
      imageNet: true,
      imageUrl:
          "https://www.visitsaudi.com/content/dam/saudi-tourism/media/articles/a175-tayebat-museum/image-1/Tayebat-Museum-jeddah.jpg",
      city: 'Jeddah',
      cityId: 4,
      provinceId: 1,
      province: 'Makkah'),
  Location(
      name: 'Al Wahbah Crater',
      description: "250 m (820 ft) deep and 2 kms in diameter volcanic crator.",
      imageNet: true,
      imageUrl:
          "https://www.halayalla.com/_next/image?url=https%3A%2F%2Fhalayallaimages-new.s3.me-south-1.amazonaws.com%2Fdmc%2Fvenue-images%2Fdmc_venue_622f1b88edadc.jpeg&w=1080&q=60",
      city: 'Taif',
      cityId: 3,
      provinceId: 1,
      province: 'Makkah'),
  Location(
      name: 'Shaqra',
      description:
          "It is a small city which is now growing due to the newly opened Shaqra University. The city is peaceful and well designed and most of the daily necessities are available.",
      imageNet: true,
      imageUrl:
          "https://i.pinimg.com/736x/2e/b5/2e/2eb52e1b071a7d0efefb83b3ed60d0a0.jpg",
      city: 'Riyadh',
      cityId: 0,
      provinceId: 0,
      province: 'Riyadh'),
];
List<Location> jeddahAncientDest = [
  Location(
      name: 'Jeddah Al-balad',
      description:
          "the historic downtown area of Jeddah originally built in the 7th century, is a memorable experience. The area’s charm has been preserved through careful restoration of the striking townhouses and narrow streets. Come for the unique architecture, the colorful markets and enchanting atmosphere.",
      imageNet: true,
      imageUrl:
          "https://scth.scene7.com/is/image/scth/NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3:crop-1920x1080?defaultImage=NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3&wid=1160&hei=652",
      city: 'Jeddah',
      province: 'Makkah'),
  Location(
      name: 'Naseef House',
      description:
          "This restored coral house was once the royal residence for King Abdul Aziz Ibn Saud, following his conquering of the city in 1925. Inside you can see ramps that were installed to allow camels to walk all the way up to the upper terrace and a beautiful neem tree at the entrance, once believed to be the only tree in Jeddah.",
      imageNet: true,
      imageUrl:
          "https://scth.scene7.com/is/image/scth/26Oct_OldJeddah_4286%20x%202411-1:crop-1920x1080?defaultImage=26Oct_OldJeddah_4286%20x%202411-1&wid=1160&hei=652",
      city: 'Jeddah',
      province: 'Makkah'),
  Location(
      name: 'Tayebat City of Science and Knowledge',
      description:
          "The Tayebat City of Science and Knowledge is a must-see museum, housing an extraordinary range of exhibits and collections. Bringing pre-Islamic and Islamic history to life, the museum spans the House of Saudi Arabian Heritage, the House of Islamic Heritage, the House of International Heritage and the Public Heritage exhibition.",
      imageNet: true,
      imageUrl:
          "https://www.visitsaudi.com/content/dam/saudi-tourism/media/articles/a175-tayebat-museum/image-1/Tayebat-Museum-jeddah.jpg",
      city: 'Jeddah',
      province: 'Makkah')
];
List<Fact> jeddahAncientFact = [
  Fact(
      content:
          "Jeddah Al-balad is the historical area of Jeddah, the second largest city of Saudi Arabia. Balad can literally be translated as 'The Town.' Balad is the historic center of the City of Jeddah.",
      location: locationsList[0]),
  Fact(
      content:
          "Nasseef House is a historical structure in Al-Balad, Jeddah. As of 2009, it is a museum and cultural center which has special exhibits and lectures given by historians.",
      location: locationsList[1]),
  Fact(
      content:
          "Al-tayebat City Museum is spread across an area of 10000 square meters, with 300 rooms in 12 buildings.",
      location: locationsList[3]),
];

List<Location> RiyadhAncientDest = [
  Location(
      name: 'Shaqra',
      description:
          "It is a small city which is now growing due to the newly opened Shaqra University. The city is peaceful and well designed and most of the daily necessities are available.",
      imageNet: true,
      imageUrl:
          "https://i.pinimg.com/736x/2e/b5/2e/2eb52e1b071a7d0efefb83b3ed60d0a0.jpg",
      city: 'Riyadh',
      province: 'Riyadh'),
];
List<Fact> RiyadhAncientFact = [
  Fact(
      content:
          "Shaqra is a town in central Saudi Arabia, The city is located about 190 kilometers north-west of the capital Riyadh.",
      location: locationsList[5]),
];

List<BlogPost> blogPosts = [
  BlogPost(
      creator: Guide(userName: "Mowfaq"),
      date: t,
      title: "Jeddah al balad",
      likes: 2000,
      // tags: ["Historical"],
      tags: [],
      imageUrl:
          "https://scth.scene7.com/is/image/scth/NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3:crop-1920x1080?defaultImage=NOV%2020%20-%20Jeddah%20Makkah%20Gate_4397%20x%203298-3&wid=1160&hei=652",
      body: "Al-Balad was founded in the 7th century and historically served as the centre of Jeddah.\n\n" +
          "Al-Balad's defensive walls were torn down in the 1940s. In the 1970s and 1980s, when Jeddah began to become wealthier due to the oil boom, many Jeddawis moved north, away from Al-Balad.\n\n"),
  BlogPost(
      creator: Guide(userName: "Ahmed"),
      date: t.subtract(Duration(days: 1)),
      title: "Why should you visit Saudi",
      likes: 3000,
      // tags: ["Historical", "Nature", "Musem"],
      tags: [],
      imageUrl: "https://welcomesaudi.com/uploads/0000/1/2021/07/23/taif.jpg",
      body: "Saudi Arabia has endless beaches on the Red Sea, many of them untouched. Vendors now offer boat trips from cities such as Jeddah, Yanbu and Al-lith.\n\n" +
          "A number of sites have shipwrecks, some quite ancient. The Red Sea offers top diving experiences, warm temperatures and great visibility.\n\n"),
];
List<Subforum> forumList = [
  Subforum(
    title: "Riyadh subforums",
    content: "discussions about Riyadh city.",
    imageUrl: "assets/images/Riyadh.jpg",
    // avatar: CircleAvatar(
    //   foregroundImage: AssetImage('assets/images/Riyadh.jpg'),
    //   backgroundColor: wPrimaryColor,
    //   radius: 22,
    // ),
    posts: riyadhPosts,
  ),
  Subforum(
    title: "Jeddah subforums",
    content: "discussions about Jeddah city.",
    imageUrl: "assets/images/Jeddah.jpg",
    // avatar: CircleAvatar(
    //   foregroundImage: AssetImage('assets/images/Jeddah.jpg'),
    //   backgroundColor: wPrimaryColor,
    //   radius: 22,
    // ),
    posts: jeddahPosts,
  ),
]; // To