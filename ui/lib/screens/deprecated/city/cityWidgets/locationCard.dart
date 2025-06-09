import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

class LocationCard extends StatelessWidget {
  final String image;
  final String locationTitle;

  const LocationCard({
    Key? key,
    required this.image,
    required this.locationTitle,
  }) : super(key: key);

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
        ),
        Container(
          height: height * 0.22,
          width: width * 0.85,
          decoration: BoxDecoration(
            color: wMagenta,
            image: DecorationImage(
              image: NetworkImage(this.image),
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
              onTap: () => {},
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
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              child: Center(child: TourCardTitle(title: this.locationTitle)),
            ),
          ],
        ),
      ),
    );
  }
}
