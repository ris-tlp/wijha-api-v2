import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/screens/tour/tourScreen.dart';
import 'package:wijha/screens/tourTab/tourCreator/createTourScreen.dart';
import 'package:wijha/widgets/constants.dart';

class TourHistoryCard extends StatelessWidget {
  final Tour tour;

  TourHistoryCard({
    required this.tour,
  });

  void goto(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (C) => TourScreen(
          tour: tour, disabled: true,
        ),
      ),
    );
  }

  DateTime _time() {
    return this.tour.dateTime;
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
                  child: Container(
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          itemContainer(
                              Icons.person,
                              tour.attendance.length
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
                ),
                traversalButton(context, CreateTourScreen(tour: tour,), Icons.restart_alt_rounded, 'Replay'),
                SizedBox(height: 8,),
                feedbackButton(context, Icons.rate_review_rounded, 'Feedback'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  feedbackBubble(BuildContext context) {
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
                height: 350,
                padding: EdgeInsets.all(wDefaultPadding),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Rate your experience',
                        style: TextStyle(
                            fontFamily: wFont,
                            color: wPrimaryColor,
                            fontSize: 18,
                            fontWeight: wBoldWeight
                        ),
                      ),
                      SizedBox(height: wDefaultPadding,),
                      RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: wMagenta,
                        ),
                        onRatingUpdate: (rating) {
                          _rating = rating;
                        },
                      ),
                      SizedBox(height: wDefaultPadding,),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Comment',
                            labelStyle: TextStyle(color: wGrey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: wPrimaryColor, width: 1.5)),
                            focusColor: wPrimaryColor,
                            fillColor: white,
                            filled: true,
                            enabled: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: wGrey, width: 2)),
                          ),
                          maxLength: 256,
                          maxLines: null,
                          minLines: null,
                          expands: true,
                          onChanged: (value) {
                            _comment = value;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          //
                          // Do something
                          //
                          Navigator.pop(context);

                          Fluttertoast.showToast(
                            msg: 'Thank you for your feedback!',
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => wPrimaryColor),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: wFont,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        }
    );
  }

  InkWell feedbackButton(BuildContext context, IconData icon, String text) {
    return InkWell(
      onTap: () => {
        feedbackBubble(context),
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
}
