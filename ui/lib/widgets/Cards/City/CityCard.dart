import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Locations/City.dart';
import '../../../screens/deprecated/city/cityScreen.dart';
import '../../constants.dart';

@Deprecated('Use DestinationInfoCard instead')
class CityCard extends StatelessWidget {
  final City city;

  CityCard({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => CityScreen())),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
            wDefaultPadding, 0, 0, 0),
        width: width * 0.47,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Positioned(
            //   right: 0,
            //   child: Container(
            //     height: height * 0.22,
            //     width: width * 0.38,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.only(
            //         topRight: Radius.circular(25),
            //         bottomRight: Radius.circular(25),
            //       )
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.only(
            //         left: 28,
            //         top: 10,
            //         right: 5,
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Text(
            //               city.description,
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 fontFamily: wFont,
            //                 color: wGrey,
            //               ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15),

              ),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      height: height * 0.24,
                      // width: width * 0.48,
                      width: width,
                      image: NetworkImage(city.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: height * 0.24,
                    // width: width * 0.48,
                    width: width,
                    decoration: BoxDecoration(
                        gradient: wPictureTint,
                        borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Text(
                                city.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  fontFamily: wFont,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Text(
                                city.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  fontFamily: wFont,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = .25
                                    ..color = wJetBlack,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                                left: 8.0,
                              ),
                              child: SvgPicture.asset(
                                locationIcon,
                                color: white,
                                height: 14.5,
                              ),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.0,
                                    left: 4,
                                  ),
                                  child: Text(
                                    city.province,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                      fontFamily: wFont,
                                      color: wPrimaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.0,
                                    left: 4,
                                  ),
                                  child: Text(
                                    city.province,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                      fontFamily: wFont,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = .15
                                        ..color = wJetBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
