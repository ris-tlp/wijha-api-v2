import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/Location.dart';

class TourLocationCard extends StatefulWidget {
  final Location location;

  const TourLocationCard({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  _TourLocationCardState createState() => _TourLocationCardState();
}

class _TourLocationCardState extends State<TourLocationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 560,
      color: Colors.red,
    );
  }
}
