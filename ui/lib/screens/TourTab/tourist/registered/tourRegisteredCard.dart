import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/screens/tour/QR/qrgenerationGuide.dart';
import 'package:wijha/screens/tour/tourScreen.dart';
import 'package:wijha/screens/tourTab/guide/active/tourRegisterationRequests.dart';
import 'package:wijha/screens/tourTab/tourist/registered/registered.dart';
import 'package:wijha/screens/userProfile/profileScreen.dart';
import 'package:wijha/widgets/constants.dart';

class TourRegisteredCard extends StatelessWidget {
  final Tour tour;

  TourRegisteredCard({
    required this.tour,
  });

  void goto(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (C) => TourScreen(
          tour: tour,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    String date = tour.dateTime.month.toString() +
        '/' +
        tour.dateTime.day.toString() +
        '/' +
        tour.dateTime.year.toString();

    return Container(
      height: 220,
      width: width * 0.85,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(2.5),
              bottomRight: Radius.circular(25)),
          color: white,
          boxShadow: [
            BoxShadow(
              color: wGrey,
              spreadRadius: .1,
              blurRadius: 1.5,
            ),
          ]),
      child: Row(
        children: [
          InkWell(
            onTap: () => goto(context),
            child: Stack(
              children: [
                Container(
                  height: 220,
                  width: 110,
                  decoration: BoxDecoration(
                    color: wMagenta,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(2.5),
                        bottomLeft: Radius.circular(2.5),
                        bottomRight: Radius.circular(15)),
                    image: DecorationImage(
                      image: NetworkImage(this.tour.images[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 220,
                  width: 110,
                  decoration: BoxDecoration(
                    gradient: wPictureTint,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(2.5),
                        bottomLeft: Radius.circular(2.5),
                        bottomRight: Radius.circular(15)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * .6,
                  child: Text(
                    tour.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: wPrimaryColor,
                      fontFamily: wFont,
                      fontSize: 18,
                      fontWeight: wBoldWeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: wGrey,
                    fontFamily: wFont,
                    fontSize: 12,
                    fontWeight: wLightWeight,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  tour.price.toString() + ' SAR',
                  style: TextStyle(
                    fontFamily: wFont,
                    fontSize: 16,
                    color: wJetBlack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        itemContainer(
                            Icons.person,
                            tour.capacity
                                .toString()), // This should be changed to reflect the actual number of participants instead of capacity
                        VerticalDivider(
                          width: 20,
                          thickness: 1,
                        ),
                        itemContainer(Icons.location_pin,
                            tour.destinations.length.toString()),
                      ],
                    ),
                  ),
                ),
                traversalButton(
                    context,
                    ProfileScreen(user: tour.guide),
                    Icons.person_pin_rounded,
                    'Guide'
                ),
                SizedBox(height: 8,),
                cancelButton(
                    context,
                    tour,
                    Icons.cancel_rounded,
                    'Cancel'
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell cancelButton(BuildContext context, Tour tour, IconData icon, String text) {
    return InkWell(
      onTap: () async => {
        cancelDialog(context, tour)
      },
      child: Container(
        width: 138,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          gradient: wGradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: wGrey,
              spreadRadius: .5,
              blurRadius: .5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(
                color: white,
                fontFamily: wFont,
                fontWeight: wBoldWeight,
              ),
            ),
            Icon(
              icon,
              size: 30,
              color: white,
            ),
          ],
        ),
      ),
    );
  }

  InkWell traversalButton(BuildContext context, target, IconData icon, String text) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (C) => target)),
      },
      child: Container(
        width: 138,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          gradient: wGradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: wGrey,
              spreadRadius: .5,
              blurRadius: .5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(
                color: white,
                fontFamily: wFont,
                fontWeight: wBoldWeight,
              ),
            ),
            Icon(
              icon,
              size: 30,
              color: white,
            ),
          ],
        ),
      ),
    );
  }

  Container itemContainer(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          gradient: wGradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: wGrey,
              spreadRadius: .5,
              blurRadius: .5,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: white,
              fontFamily: wFont,
              fontWeight: wBoldWeight,
            ),
          ),
          Icon(
            icon,
            color: white,
            size: 30,
          ),
        ],
      ),
    );
  }

  cancelDialog(BuildContext context, Tour tour) {
    showDialog(
        context: context,
        builder: (context) {
          double _rating = 0;
          String _comment = '';

          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15.0)
                  )
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: white,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Are you sure you want to cancel registration?',
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
                              tour.removeRequest(tourist),
                              // tourist.tourList.remove(tour),
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisteredTours()))
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
                            onTap: () => {Navigator.pop(context)},
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
              )
          );
        }
    );
  }
}
