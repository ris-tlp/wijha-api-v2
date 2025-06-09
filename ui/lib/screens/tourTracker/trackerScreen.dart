import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Tours/TourTracker.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/Tourist.dart';
import 'package:wijha/screens/tourTracker/tourTrackerWidgets/locationFactCard.dart';
import 'package:wijha/widgets/constants.dart';
import "dart:math" show pi;

import '../../models/Tours/Tour.dart';
import '../../providers/authProvider.dart';

class TrackerScreen extends ConsumerStatefulWidget {
  final TourTracker tracker;

  TrackerScreen({
    required this.tracker,
  });

  @override
  ConsumerState<TrackerScreen> createState() => _TrackerScreen();
}

class _TrackerScreen extends ConsumerState<TrackerScreen> {
  late int _currentValue;

  /// set currentProgress to be retrieved from model
  late int i;
  late int placeCount;

  ///get place count from model

  setEndPressed(int value) {
    setState(() {
      _currentValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentValue = this.widget.tracker.currentLocation;
    placeCount = this.widget.tracker.tour.destinations.length;
    i = this.widget.tracker.currentLocation;
  }

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle =
        const TextStyle(fontSize: 16.0, color: Colors.white);
    return new FloatingActionButton(
        child: new Text(text, style: roundTextStyle), onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final progressBarWidth = 270.0;
    final progressBarHeight = 270.0;
    final imageWidth = progressBarWidth - 30;
    final imageHeight = progressBarHeight - 30;
    return Scaffold(
      backgroundColor: wBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          width: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Tour Tracker',
                style: TextStyle(
                  color: white,
                  fontFamily: wFont,
                  fontSize: 20,
                ),
              ),
              Icon(
                Icons.share_location_sharp,
                color: white,
                size: 25,
              ),
            ],
          ),
        ),
        backgroundColor: wPurple,
      ),
      body: !this.widget.tracker.active
          ? InkWell(
              onTap: () => setState(() {
                // this.widget.tracker.tour.status = 1;
                // for (tourist in this
                //     .widget
                //     .tracker
                //     .attending
                //     .map((user) => user as Tourist)) {
                //   tourist.setInTour();
                // }
                this.widget.tracker.activateTracker();
                this.widget.tracker.active = true;
                print("in here");
              }),
              child: Container(
                height: screenHeight,
                width: MediaQuery.of(context).size.width,
                color: wPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      size: 200,
                      color: white,
                    ),
                    Text(
                      'Start',
                      style: TextStyle(
                        color: white,
                        fontSize: 28,
                        fontFamily: wFont,
                        fontWeight: wBoldWeight,
                      ),
                    )
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularStepProgressIndicator(
                                  totalSteps: placeCount,
                                  currentStep: (_currentValue + 1).toInt(),
                                  padding: pi / 15,
                                  stepSize: 10,
                                  width: progressBarWidth,
                                  height: progressBarHeight,
                                  selectedColor: wPrimaryColor,
                                  unselectedColor: wJetBlack,
                                ),
                              ],
                            ),
                          ),
                          Card(
                            shape: CircleBorder(),
                            color: wPurple,
                            child: Container(
                              width: imageWidth,
                              height: imageHeight,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: locationImages(i),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: LocationFactCard(
                      fact: getFact(i),
                      icon: Icon(
                        Icons.fact_check_rounded,
                        size: 42,
                        color: wPrimaryColor,
                      ),
                    ),
                  ),
                  Consumer(builder: (context, ref, _) {
                    final _auth = ref.watch(userProvider.notifier);
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _currentValue <
                                  this.widget.tracker.tour.destinations.length -
                                      1
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: wPrimaryColor,
                                  ),
                                  onPressed: () {
                                    if (true)

                                    /// _auth.getUser() == widget.tour.guide
                                    if (i < placeCount) {
                                      i++;
                                      setEndPressed(i);
                                      locationImages(i);
                                      this.widget.tracker.tour.incrementStep();
                                    } else if (i <
                                        this.widget.tracker.tour.progress) {
                                      i++;
                                      setEndPressed(i);
                                      locationImages(i);
                                      this.widget.tracker.tour.incrementStep();

                                      /// For the demo only
                                    }
                                  },
                                  child: Container(
                                      width: 120,
                                      alignment: Alignment.center,
                                      child: Text(_auth.getUser() ==
                                              this.widget.tracker.guide
                                          ? 'Update Location'
                                          : 'Next')),
                                )
                              : (_auth.getUser() is Guide) /// Should compare ID but this solution can work temporarily
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: wPrimaryColor,
                                      ),
                                      onPressed: () async {
                                        // bool confirm = await confirmDialog(context);
                                        // if (confirm) {
                                        setState(() {
                                          // guide.tourList.remove(widget.tour);
                                          // guide.tourHistoryList.add(widget.tour);
                                          this.widget.tracker.tour.status = -1;
                                          for (tourist in this
                                              .widget
                                              .tracker
                                              .tour
                                              .registrationRequests
                                              .map((request) =>
                                                  request.user as Tourist)) {
                                            tourist.setOutOfTour();
                                            tourist.removeActiveTour();
                                            tourist
                                                .addPoints(Tour.travelPoints);
                                            this
                                                .widget
                                                .tracker
                                                .tour
                                                .guide
                                                .addPoints(Tour.travelPoints *
                                                    .5 ~/
                                                    1);
                                          }
                                          Navigator.pop(context, true);
                                        });
                                        //   }
                                      },
                                      child: Container(
                                          width: 120,
                                          alignment: Alignment.center,
                                          child: Text('End Tour')),
                                    )
                                  : Container(),

                          if (this.widget.tracker.tour.destinations.length != 1)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: wPrimaryColor,
                              ),
                              onPressed: () {
                                if (i > 0) {
                                  i--;
                                  setEndPressed(i);
                                  locationImages(i);
                                  // if (_auth.getUser() == widget.tour.guide) widget.tour.decrementStep();

                                  this.widget.tracker.tour.decrementStep();

                                  /// For the demo only
                                }
                              },
                              child: Container(
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: Text(_auth.getUser() ==
                                          this.widget.tracker.guide
                                      ? 'Undo Update'
                                      : 'Back')),
                            ),
                          // FloatingActionButton(
                          //   child: Text("E"),
                          //   onPressed: () {
                          //     Navigator.push(context, new MaterialPageRoute(builder: (context) => Onboarding(screenHeight: screenHeight,),)
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    );
                  }),
                ],
              )),
            ),
    );
  }

  /// get images from the model
  locationImages(int index) {
    return NetworkImage(this.widget.tracker.tour.destinations[index].imageUrl);
  }

  getFact(int index) {
    return this.widget.tracker.tour.facts[index].content;
  }

  confirmDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          double _rating = 0;
          String _comment = '';

          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Are you sure you want to end the tour?',
                      style: TextStyle(
                        color: wJetBlack,
                        fontWeight: wBoldWeight,
                        fontSize: 14,
                        fontFamily: wFont,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => {
                              Navigator.pop(context, true),
                            },
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: white, width: .25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: white,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: wBoldWeight,
                                      fontSize: 14,
                                      fontFamily: wFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => {Navigator.pop(context, false)},
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: white, width: .25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: white,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'No',
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: wBoldWeight,
                                      fontSize: 14,
                                      fontFamily: wFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
