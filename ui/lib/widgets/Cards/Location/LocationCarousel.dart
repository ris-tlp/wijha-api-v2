import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/widgets/constants.dart';

@Deprecated('Use DestinationCardList instead')
class CityCarousel extends StatelessWidget {
  final List<City> cityList;

  CityCarousel({
    Key? key,
    required this.cityList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      fontWeight: FontWeight.w600,
                      fontFamily: wFont,
                    ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index) {
                City city = cityList[index];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  width: 210,
                  color: Colors.red,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 120,
                          width: 210,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(0.5),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(0.5),
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    city.name,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                      fontFamily: wFont,
                                      color: wPrimaryColor,
                                    ),
                                ),
                                Text(
                                    city.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: wFont,
                                      color: wGrey,
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(0.5),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(2.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6)
                          ]
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(0.5),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(2.5),
                              ),
                              child: Image(
                                height: 180,
                                width: 210,
                                image: AssetImage(city.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Column(
                            //
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}
