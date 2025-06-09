import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/screens/Province/provinceScreen.dart';
import '../../constants.dart';

@Deprecated('Use DestinationInfoCard instead')
class ProvinceCard extends StatelessWidget {
  final Province province;

  ProvinceCard({
    Key? key,
    required this.province,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => ProvinceScreen(province: province,))),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
            wDefaultPadding, wDefaultPadding, 0, wDefaultPadding),
        width: width * 0.47,
        // decoration: BoxDecoration(
        //   boxShadow:
        //   [
        //     BoxShadow(
        //       offset: Offset(0, 8),
        //       blurRadius: 10,
        //       color: wGrey.withOpacity(0.60),
        //     ),
        //   ],
        // ),
        child: Stack(
          alignment: Alignment.center,
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
                      image: AssetImage(province.imageUrl),
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                                left: 8,
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
                                    left: 8.0,
                                  ),
                                  child: Text(
                                    province.name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                      fontFamily: wFont,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.0,
                                    left: 8.0,
                                  ),
                                  child: Text(
                                    province.name,
                                    style: TextStyle(
                                      fontSize: 20,
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
