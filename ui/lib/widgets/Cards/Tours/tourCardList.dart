import 'package:flutter/material.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/widgets/Cards/Tours/tourCard.dart';
import '../../constants.dart';

class TourCardList extends StatelessWidget {
  final List<Tour> toursList;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final int itemCount;

  TourCardList({required this.toursList, this.scrollDirection = Axis.horizontal, this.shrinkWrap = false, this.itemCount = 7, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool vertical = scrollDirection == Axis.vertical ? true : false;
    return Container(
      margin: vertical ? EdgeInsets.all(0) : EdgeInsets.fromLTRB(10, wDefaultPadding, 0, 0),
      child: ListView.builder(
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection,
          itemCount: toursList.length < itemCount ? toursList.length : itemCount,
          itemBuilder: (BuildContext context, int index) {
            Tour tour = toursList[index];
            return TourCard(tour: tour, vertical: vertical,);
          }),
    );
  }
}
