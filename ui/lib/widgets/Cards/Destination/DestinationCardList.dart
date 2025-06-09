import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/DestinationInterface.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/widgets/Cards/Destination/DestinationInfoCard.dart';

import '../../constants.dart';

class DestinationCardList extends StatelessWidget {
  final List<Destination> destinationList;
  final Axis scrollDirection;
  final bool detailed;
  final shrinkWrap;
  final maxDestinations;

  DestinationCardList({
    required this.destinationList,
    this.scrollDirection = Axis.horizontal,
    this.detailed = true,
    this.shrinkWrap = false,
    this.maxDestinations = 7,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    bool vertical = false;

    if (scrollDirection == Axis.vertical)
      vertical = true;

    return Container(
      // height: height * .28,
      width: width,
      clipBehavior: Clip.none,
      margin: vertical ? EdgeInsets.all(0) : EdgeInsets.fromLTRB(10, wDefaultPadding, 0, 0),
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        scrollDirection: scrollDirection,
        itemCount: min(destinationList.length, maxDestinations),
        itemBuilder: (BuildContext context, int index) {
          Destination destination = destinationList[index];
          return DestinationInfoCard(destination: destination, detailed: detailed, vertical: vertical,);
        }
      ),
    );
  }
}
