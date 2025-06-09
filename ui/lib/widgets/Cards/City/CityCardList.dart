import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/City.dart';
import '../../constants.dart';
import 'CityCard.dart';

@Deprecated('Use DestinationCardList instead')
class CityCardList extends StatelessWidget {
  final List<City> cityList;

  CityCardList({
    required this.cityList,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.28,
      padding: const EdgeInsets.fromLTRB(
          0, 0, wDefaultPadding, 0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: min(cityList.length, 4),
          itemBuilder: (BuildContext context, int index) {
            City city = cityList[index];
            return CityCard(city: city);
          }
      ),
    );
  }
}
