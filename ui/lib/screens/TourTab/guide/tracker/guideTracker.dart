// Page for guides to start tours, track attendance list and update tracker
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Tours/TourTracker.dart';
import 'package:wijha/providers/tourProvider.dart';
import 'package:wijha/screens/tour/QR/qrgenerationGuide.dart';
import 'package:wijha/screens/tourTracker/trackerScreen.dart';
import 'package:wijha/widgets/loading.dart';

import '../../../../models/Users/User.dart';
import '../../../../providers/authProvider.dart';
import '../../../../widgets/constants.dart';

class GuideTrackerPage extends ConsumerStatefulWidget {
  const GuideTrackerPage({Key? key}) : super(key: key);

  @override
  ConsumerState<GuideTrackerPage> createState() => _GuideTrackerPageState();
}

class _GuideTrackerPageState extends ConsumerState<GuideTrackerPage> {
  List<Tour>? tours;
  List<Tour>? displayTours;
  int counter = 0;
  Future<List<Tour>>? futureTours;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    // tours = guide.tourList;
  }

  getTours(_user) {
    futureTours = Tour.fetchInactiveTours(_user.userName, false);
    futureTours!.then((data) => setState(() {
          tours = data;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      // tours = ref.watch(tourProvider.notifier).getToursByGuide(_auth.getUser());
      final User user = _auth.getUser();

      if (tours != null) {
        if (counter == 0) {
          displayTours = tours!
              .where((tour) => tour.dateTime
                  .isAfter(DateTime.now().subtract(Duration(days: 4))))
              .toList();
          counter = 1;
          loading = false;
        }
      } else {
        getTours(user);
      }

      return loading
          ? Loading()
          : SafeArea(
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          expandedHeight: 60,
                          centerTitle: true,
                          title: SvgPicture.asset(
                            wLogo,
                            color: white,
                            height: 25,
                          ),
                          backgroundColor: wPurple,
                          forceElevated: innerBoxIsScrolled,
                        ),
                      ),
                    ];
                  },
                  body: displayTours!.length > 0
                      ? SingleChildScrollView(
                          child: Container(
                            height: height,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: width,
                                  height: 120,
                                  decoration:
                                      BoxDecoration(color: wPurple, boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, .5),
                                      color: wGrey,
                                      blurRadius: 1.5,
                                      spreadRadius: 1.5,
                                    )
                                  ]),
                                  child: Text(
                                    'Choose a tour to start',
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: wBoldWeight,
                                      fontFamily: wFont,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 599,
                                  child: ListView.builder(
                                    itemCount: displayTours!.length,
                                    itemBuilder: (context, index) {
                                      final tour = displayTours![index];
                                      return buildLocation(index, tour, width);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            "You have no tours set for the next 4 days!",
                            style: TextStyle(
                              color: wJetBlack,
                              fontSize: 18,
                              fontFamily: wFont,
                              fontWeight: wBoldWeight,
                            ),
                          ),
                        ),
                ),
              ),
            );
    });
  }

  Widget buildLocation(int index, Tour tour, double width) => InkWell(
        onTap: () async {
          bool done = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => Tracker(tour: tour)));
          if (done) Navigator.pop(context, true);
        },
        child: Card(
          elevation: 2,
          key: ValueKey(tour),
          margin: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
          child: ListTile(
            leading: Container(
              width: width * .25,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  tour.images[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Container(
              width: width * .65,
              child: Text(
                tour.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: wFont,
                  fontSize: 16,
                  fontWeight: wBoldWeight,
                  color: wMagenta,
                ),
              ),
            ),
            // subtitle: RichText(
            //   strutStyle: StrutStyle(
            //     fontFamily: wFont,
            //     fontSize: 12,
            //   ),
            //   text: TextSpan(
            //       text: 'Current attendance: ',
            //       style: TextStyle(
            //         color: wGrey,
            //       ),
            //       children: [
            //         TextSpan(
            //             text: tour.attendance.length.toString(),

            //             /// Change from capacity to attendance
            //             style: TextStyle(
            //               color: wPrimaryColor,
            //               fontWeight: wBoldWeight,
            //             ))
            //       ]),
            // ),
          ),
        ),
      );
}

class Tracker extends StatefulWidget {
  final Tour tour;
  const Tracker({required this.tour, Key? key}) : super(key: key);

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  bool loading = true;
  TourTracker? tracker;
  Future<dynamic>? futureTracker;

  @override
  void initState() {
    super.initState();
    futureTracker = TourTracker.fetchTrackerByTour(this.widget.tour);
    futureTracker!.then((data) => setState(() {
          if (data != null) {
            tracker = data;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    if (tracker != null) {
      loading = false;
    }

    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: wBackgroundColor,
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: SvgPicture.asset(
                  wLogo,
                  color: white,
                  height: 25,
                ),
                backgroundColor: wPurple,
              ),
              body: Stack(
                children: [
                  Container(
                    width: width,
                    height: height - 80,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: tracker!.attending.length > 0
                        ? Column(
                            children: [
                              Text(
                                'Current Attendance',
                                style: TextStyle(
                                  color: wJetBlack,
                                  fontSize: 18,
                                  fontWeight: wBoldWeight,
                                  fontFamily: wFont,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: height * .68,
                                child: ListView.builder(
                                  itemCount: tracker!.attending.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final user = tracker!.attending[index];
                                    return attendantCard(user);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'This tour has no attendants yet!',
                            style: TextStyle(
                              color: wJetBlack,
                              fontSize: 20,
                              fontWeight: wBoldWeight,
                              fontFamily: wFont,
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      height: 120,
                      decoration: BoxDecoration(
                          color: wPurple,
                          border:
                              Border(top: BorderSide(color: white, width: 5)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2.5, spreadRadius: .5, color: wGrey)
                          ]),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRGenerationGuide(
                                          tour: tracker!.tour))),
                              child: Container(
                                width: width * .45,
                                child: Icon(
                                  Icons.qr_code_2_rounded,
                                  color: white,
                                  size: 100,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: white,
                              thickness: 2.5,
                            ),
                            InkWell(
                              onTap: () async {
                                bool done = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TrackerScreen(
                                              tracker: tracker!,
                                            )));
                                if (done) Navigator.pop(context, true);
                              },
                              child: Container(
                                width: width * .45,
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: white,
                                  size: 100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  attendantCard(User attendant) {
    return Card(
      elevation: 2,
      key: ValueKey(attendant),
      margin: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                attendant.profilePicture,
                fit: BoxFit.cover,
                scale: 10,
              )),
        ),
        title: Text(
          attendant.userName,
          style: TextStyle(
            fontFamily: wFont,
            fontSize: 16,
            fontWeight: wBoldWeight,
            color: wMagenta,
          ),
        ),
        // subtitle: RichText(
        //   strutStyle: StrutStyle(
        //     fontFamily: wFont,
        //     fontSize: 12,
        //   ),
        //   text: TextSpan(
        //       text: 'Current attendance: ',
        //       style: TextStyle(
        //         color: wGrey,
        //       ),
        //       children: [
        //         TextSpan(
        //             text: tour.capacity.toString(),
        //             style: TextStyle(
        //               color: wPrimaryColor,
        //               fontWeight: wBoldWeight,
        //             )
        //         )
        //       ]
        //   ),
        // ),
      ),
    );
  }
}
