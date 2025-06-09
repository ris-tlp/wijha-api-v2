import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/widgets/constants.dart';
import '../../../widgets/Cards/City/CityCardList.dart';
import '../../../widgets/Cards/Destination/DestinationCardList.dart';
import 'SeeAllCity.dart';

@Deprecated('Use DestinationCarousel instead')
class CityCarousel extends StatelessWidget {
  final List<City> cityList;

  CityCarousel({
    Key? key,
    required this.cityList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
            color: Colors.black12
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5,),
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AllCityScreen(cityList: cityList),
                  )),
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
          //CityCardList(cityList: cityList,)
          Container(
            height: height * .28,
            child: DestinationCardList(destinationList: cityList),
          )
        ],
      ),
    );
  }
}
