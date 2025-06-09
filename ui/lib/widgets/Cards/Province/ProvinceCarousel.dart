import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/DestinationInterface.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/widgets/constants.dart';

import '../Destination/DestinationCardList.dart';

@Deprecated('Use DestinationCarousel instead')
class ProvinceCarousel extends StatelessWidget {
  final List<Destination> destinationList;

  ProvinceCarousel({
    Key? key,
    required this.destinationList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Cities in this province',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: wFont,
                ),
              ),
              GestureDetector(
                onTap: () => print('See all cities screen'),
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: wMagenta,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: wFont,
                  ),
                ),
              ),
            ],
          ),
        ),
        DestinationCardList(destinationList: destinationList)
      ],
    );
  }
}
