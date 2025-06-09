import 'package:flutter/material.dart';
import 'package:wijha/data.dart';
import 'package:wijha/screens/TourTab/tourTabWidgets/cardButton.dart';
import 'package:wijha/screens/tourTab/tourist/touristTourScreen.dart';
import '../tourCreator/createTourScreen.dart';
import 'active/activeTour.dart';
import 'customLocation/customLocationList.dart';
import 'history/history.dart';

class GuideTourScreen extends StatefulWidget {
  @override
  State<GuideTourScreen> createState() => _GuideTourScreen();
}

class _GuideTourScreen extends State<GuideTourScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: .65,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          children: [
            CardButton(
              text: 'Active Tours',
              icon: Icons.tour_rounded,
              target: ActiveTours(),
            ),
            CardButton(
              text: 'Custom Locations',
              icon: Icons.location_city_rounded,
              target: CustomLocationList(),
            ),
            CardButton(
              text: 'History',
              icon: Icons.history_edu_rounded,
              target: History(),
            ),
            CardButton(
              text: 'Create Tour',
              icon: Icons.create_rounded,
              target: CreateTourScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
