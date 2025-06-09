import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/widgets/constants.dart';

class HeaderWithTag extends StatefulWidget {
  final String cityImage;
  final String city;

  const HeaderWithTag({
    Key? key,
    required this.size,
    required this.cityImage,
    required this.city,
  }) : super(key: key);
  final Size size;

  @override
  State<HeaderWithTag> createState() => _HeaderWithTagState();
}

class _HeaderWithTagState extends State<HeaderWithTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // It will cover 65% of our total height
      height: widget.size.height * 0.65,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          // Positioned(
          //   child: Container(
          //     alignment: Alignment.bottomLeft,
          //     margin: EdgeInsets.symmetric(horizontal: wDefaultPadding),
          //     height: 30,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //         bottomRight: Radius.circular(10),
          //         bottomLeft: Radius.circular(10),
          //       ),
          //       color: wPrimaryColor,
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: wDefaultPadding,
          //       ),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: <Widget>[
          //           Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
          //           Text(
          //             this.widget.tag,
          //             textAlign: TextAlign.end,
          //             style: const TextStyle(
          //               fontWeight: FontWeight.normal,
          //               color: Colors.white,
          //               fontSize: 16,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(
              left: wDefaultPadding,
              right: wDefaultPadding,
              bottom: 36 + wDefaultPadding,
            ),
            height: widget.size.height * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              image: DecorationImage(
                image: AssetImage(this.widget.cityImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: wDefaultPadding),
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: wPrimaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: wDefaultPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 18,
                      width: 18,
                      child: SvgPicture.asset(
                        'assets/icons/location.svg',
                        color: Colors.white,
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                    Text(
                      this.widget.city,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
