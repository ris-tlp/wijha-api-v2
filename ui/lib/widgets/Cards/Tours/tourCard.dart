import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/screens/tour/tourScreen.dart';
import 'package:wijha/widgets/constants.dart';

class TourCard extends StatelessWidget {
  final Tour tour;
  final bool vertical;

  TourCard({
    required this.tour,
    this.vertical = false,
  });

  void selectTour(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (C) => TourScreen(
              tour: tour,
            )));
  }

  DateTime _time() {
    return this.tour.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    List months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    var tourMon = _time().month;
    var tourDay = _time().day;

    String date = tourDay.toString() + " " + months[tourMon - 1];

    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.28,
      width: vertical ? width : width * 0.85,
      margin: vertical ? EdgeInsets.symmetric(vertical: 0) : EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: vertical ? BorderRadius.circular(2) : BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: height * 0.22,
            width: vertical ? width : width * 0.85,
            decoration: BoxDecoration(
              color: wMagenta,
              image: DecorationImage(
                image: NetworkImage(this.tour.images[0]),
                fit: BoxFit.cover,
              ),
              borderRadius: vertical ? BorderRadius.circular(1) : BorderRadius.circular(15),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: vertical ? Radius.circular(1) : Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  gradient: wGradient,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: white,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      date,
                      style: TextStyle(
                        color: white,
                        fontFamily: wFont,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )),
          cardInfo(width, context),
          Container(
            height: height * 0.22 + 30,
            width: width * 0.85,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: vertical ? BorderRadius.circular(2) : BorderRadius.circular(15),
                splashColor: wPrimaryColor.withAlpha(80),
                onTap: () => selectTour(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned cardInfo(double width, context) {
    return Positioned(
      top: MediaQuery.of(context).size.longestSide * 0.22 - 30,
      child: Container(
        width: vertical ? width * .95 : width * 0.75,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.all(vertical ? Radius.circular(10) : Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              child: Center(child: TourCardTitle(title: this.tour.title)),
            ),
            Container(
              width: vertical ? width * .95 : width * 0.75,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: wBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  bottom: vertical ? Radius.circular(3) : Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: vertical ? width * .95 / 2 : width * 0.75 / 2,
                    child: priceTag(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: vertical ? width * (.95 / 2) * .35 : width * (0.75 / 2) * 0.35,
                    child: destTag(),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: wGrey,
                          width: 0.2,
                        ),
                        left: BorderSide(
                          color: wGrey,
                          width: 0.2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: vertical ? width * (.95 / 2) * .65 : width * (0.75 / 2) * 0.65,
                    child: ratingTag(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FittedBox priceTag() {
    return FittedBox(
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/money.svg',
            color: Colors.green,
            height: 13,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
          Text(
            this.tour.price.toString() + ' SAR',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  FittedBox destTag() {
    return FittedBox(
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/trip.svg',
            color: wPurple,
            height: 13,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
          Text(
            this.tour.destinations.length.toString(),
            style: TextStyle(
              color: wPurple,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  FittedBox ratingTag() {
    return FittedBox(
      fit: BoxFit.fill,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/star.svg',
            color: Colors.orange,
            height: 13,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
          Text(
            this.tour.rating.toString(),
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
          Text(
            '(' + tour.reviews.length.toString() + ')',
            style: TextStyle(
              color: wGrey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
