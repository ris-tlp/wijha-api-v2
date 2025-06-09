import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';

import '../../../widgets/constants.dart';

class LocationFactCard extends StatelessWidget {
  final String fact;
  final Widget icon;

  const LocationFactCard({Key? key, required this.fact, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 8.0,
          bottom: 10.0,
          right: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 160,
                child: Column(
                  children: [
                    Row(
                    children: [
                      icon,
                      SizedBox(
                        width: (MediaQuery.of(context).size.width)/5,
                      ),
                      Text(
                        "Location Fact",
                        style: TextStyle(
                          fontFamily: wFont,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      ],
                     ),
                    Expanded(
                      child:
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(fact,style: TextStyle(fontFamily: wFont, fontSize: 18, fontWeight: FontWeight.w300),),
                      ),
                    ),
                  ],

                ),
            ),
        ),
            Align(
              alignment: Alignment.bottomRight,
              child:
              FavoriteButton(
                iconSize: 35,
                iconColor: wPrimaryColor,
                isFavorite: false,
                // iconDisabledColor: Colors.white,
                valueChanged: (_isFavorite) {
                  print('Is Favorite : $_isFavorite');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
