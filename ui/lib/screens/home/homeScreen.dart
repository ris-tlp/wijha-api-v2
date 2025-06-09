import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/models/Tours/TourTracker.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/tourProvider.dart';
import 'package:wijha/screens/home/homeWidgets/ctgList.dart';
import 'package:wijha/widgets/Cards/Tours/tourCardList.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import '../../models/Tours/Tour.dart';
import '../../models/Users/Tourist.dart';
import '../../providers/provinceProvider.dart';
import '../../widgets/Cards/Destination/DestinationCardList.dart';
import '../tourTracker/tourTrackerWidgets/trackerPulse.dart';
import '../tourTracker/trackerScreen.dart';
import 'allDestinationScreen.dart';
import 'allToursScreen.dart';
import 'homeWidgets/headerSearchbox.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool loading = true;
  bool? isTrackerActive = false;
  List<Tour>? tours;
  List<City>? cities;
  int counter = 0;
  TourTracker? tracker;
  Future<bool>? futureIsTrackerActive;
  Future<List<Tour>>? futureTours;
  Future<List<City>>? futureCities;
  Future<dynamic>? futureTracker;

  fetchTours(String provinceName) {
    futureTours = Tour.fetchToursInProvince(provinceName);
    futureTours!.then((data) => setState(() {
          tours = data;
        }));
  }

  fetchCitiesInProvince(String provinceName) {
    futureCities = Province.fetchCitiesInProvince(provinceName);
    futureCities!.then((data) => setState(() {
          cities = data;
        }));
  }

  fetchTrackerIfActive(Tourist user) {
    futureTracker = user.fetchActiveTourTracker();
    futureTracker!.then((data) => setState(() {
          if (data is bool && !data) {
            isTrackerActive = false;
          } else {
            tracker = data;
            isTrackerActive = true;
          }
          counter = 1;
        }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      final province = ref.watch(provinceProvider.notifier);
      final _auth = ref.watch(userProvider.notifier);

      // List<Tour> tours = ref
      //     .watch(tourProvider.notifier)
      //     .getTours()
      //     .where((tour) =>
      //         provinceData[tour.city.provinceId] == province.getProvince())
      //     .toList();
      // List<City> _cityList = cityList
      //     .where(
      //         (city) => provinceData[city.provinceId] == province.getProvince())
      //     .toList();

      if (tours != null && cities != null) {
        if (isTrackerActive == true) {
          loading = false;
        }
        loading = false;
      } else {
        if (_auth.getUser() is Tourist && counter == 0) {
          fetchTrackerIfActive(_auth.getUser());
        }
        fetchTours(province.getProvince().name);
        fetchCitiesInProvince(province.getProvince().name);
      }
      return loading
          ? Loading()
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        HeaderWithSearchBox(
                          size: size,
                        ),
                        SizedBox(height: wDefaultPadding),
                        Container(
                          alignment: Alignment.topLeft,
                          child: TabBar(
                            tabs: [
                              Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Tours',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: wFont,
                                        fontSize: 20,
                                        fontWeight: wBoldWeight),
                                  )),
                              Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Cities',
                                    style: TextStyle(
                                        fontFamily: wFont,
                                        fontSize: 20,
                                        fontWeight: wBoldWeight),
                                  )),
                              // Container(
                              //     padding: EdgeInsets.only(bottom: 5),
                              //     child: Text(
                              //       'Events',
                              //       style: TextStyle(
                              //           fontFamily: wFont,
                              //           fontSize: 20,
                              //           fontWeight: wBoldWeight),
                              //     )),
                            ],
                            padding: EdgeInsets.only(left: 10),
                            indicatorSize: TabBarIndicatorSize.label,
                            isScrollable: true,
                            labelColor: wPrimaryColor,
                            indicatorColor: wPrimaryColor,
                            indicatorWeight: 3,
                            unselectedLabelColor: wGrey,
                            automaticIndicatorColorAdjustment: false,
                            labelPadding: EdgeInsets.only(right: 10, left: 10),
                          ),
                        ),
                        Container(
                          height: 250,
                          child: TabBarView(
                            children: [
                              // first tab bar view widget
                              Container(
                                child: Center(
                                  child: tours!.length > 0
                                      ? Stack(children: [
                                          Positioned(
                                              top: 0,
                                              right: 10,
                                              child: GestureDetector(
                                                onTap: () => {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllToursScreen(
                                                                province: province
                                                                    .getProvince(),
                                                                tours: tours!,
                                                              )))
                                                },
                                                child: Text(
                                                  'See All',
                                                  style: TextStyle(
                                                      color: wMagenta,
                                                      fontFamily: wFont,
                                                      fontSize: 16,
                                                      letterSpacing: .7),
                                                ),
                                              )),
                                          TourCardList(toursList: tours!)
                                        ])
                                      : Container(
                                          child: Center(
                                            child: Text(
                                              'There are no tours in this province currently',
                                            ),
                                          ),
                                        ),
                                ),
                              ),

                              // second tab bar view widget
                              Container(
                                child: cities!.length > 0
                                    ? Stack(children: [
                                        Positioned(
                                            top: 0,
                                            right: 10,
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllDestinationScreen(
                                                                destinationList:
                                                                    cities!)))
                                              },
                                              child: Text(
                                                'See All',
                                                style: TextStyle(
                                                    color: wMagenta,
                                                    fontFamily: wFont,
                                                    fontSize: 16,
                                                    letterSpacing: .7),
                                              ),
                                            )),
                                        DestinationCardList(
                                          destinationList: cities!,
                                        )
                                      ])
                                    : Container(
                                        child: Center(
                                          child: Text(
                                            'There are no cities in this province currently',
                                          ),
                                        ),
                                      ),
                              ),

                              // third tab bar view widget
                              // Container(
                              //   child: Center(
                              //     child: Text(
                              //       'There are no events in this location currently',
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                          padding:
                              EdgeInsets.fromLTRB(wDefaultPadding, 0, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                categoryIcon,
                                height: 22,
                                color: wPrimaryColor,
                              ),
                              SizedBox(width: 5),
                              WTitle(title: 'Tours Categories')
                            ],
                          )),
                      Container(
                          child: CategoriesList(categoriesList: categories)),
                      Consumer(builder: (context, ref, _) {
                        if (_auth.getUser() is Tourist) {
                          Tourist user = _auth.getUser() as Tourist;

                          // final tour =
                          //     ref.watch(tourProvider.notifier).getActiveTours();

                          /// For demo only

                          if (isTrackerActive!) {
                            return Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child: PulsatingCircleIconButton(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TrackerScreen(
                                        tracker: tracker!,

                                        /// For demo only
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.share_location_sharp,
                                  color: white,
                                  size: 35,
                                ),
                                text: Text(
                                  "Your Tour has begun. Tap to keep track!",
                                  style: TextStyle(
                                      fontFamily: wFont,
                                      color: white,
                                      fontSize: 16),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      })
                    ],
                  ),
                ),
              ],
            );
    });
  }
}
