import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/widgets/constants.dart';

class TourCard extends StatelessWidget {
  final int id;
  final List<String> images;

  final String tourTitle;
  final double price;
  final String rating;
  final String ratingCount;
  final List<String> dest;

  TourCard({
    required this.id,
    required this.images,
    required this.tourTitle,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.dest,
  });

  // void selectTour(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (C) => TourScreen(
  //           id: id,
  //           title: tourTitle,
  //           price: price,
  //           imgs: images,
  //           guide: 'guide',
  //           destenations: dest,
  //           categories: [],
  //           description: 'description')));
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: height * 0.28,
          width: width * 0.85,
          margin: EdgeInsets.symmetric(horizontal: 10),
        ),
        Container(
          height: height * 0.22,
          width: width * 0.85,
          decoration: BoxDecoration(
            color: wMagenta,
            image: DecorationImage(
              image: NetworkImage(this.images[0]),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cardInfo(width),
        Container(
          height: height * 0.255,
          width: width * 0.85,
          child: new Material(
            color: Colors.transparent,
            child: new InkWell(
              borderRadius: BorderRadius.circular(15),
              splashColor: wPrimaryColor.withAlpha(80),
              // onTap: () => selectTour(context),
            ),
          ),
        ),
      ],
    );
  }

  Positioned cardInfo(double width) {
    return Positioned(
      bottom: wDefaultPadding,
      child: Container(
        width: width * 0.75,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              child: Center(child: TourCardTitle(title: this.tourTitle)),
            ),
            Container(
              width: width * 0.75,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: wBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
                    width: width * 0.75 / 2,
                    child: priceTag(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width * (0.75 / 2) * 0.35,
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
                    width: width * (0.75 / 2) * 0.65,
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
            this.price.toString() + ' SAR',
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
            this.dest.length.toString(),
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
            this.rating,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
          Text(
            '(' + this.ratingCount + ')',
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
