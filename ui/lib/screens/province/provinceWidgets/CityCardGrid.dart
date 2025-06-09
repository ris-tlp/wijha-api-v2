import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/widgets/Cards/City/CityCard.dart';
import 'package:wijha/widgets/constants.dart';

class CityCardGrid extends StatelessWidget {
  final List<City> cityList;

  CityCardGrid({
    required this.cityList,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return GridView.builder(
          padding: EdgeInsets.only(right: wDefaultPadding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
          ),
          itemCount: cityList.length,
          itemBuilder: (BuildContext context, int index) {
              City city = cityList[index];
              return CityCard(city: city);
            },
      );
  }
}
