import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/widgets/constants.dart';

class TourCtg extends StatelessWidget {
  final String icon;
  final String ctgName;

  const TourCtg({
    Key? key,
    required this.icon,
    required this.ctgName,
    action,
  }) : super(key: key);

  final double btnHeight = 22;
  final double ctgIconSize = 14;
  final double ctgFontSize = 14;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        height: btnHeight,
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                wPrimaryColor,
                wPurple,
              ],
            ),
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              this.icon,
              color: Colors.white,
              height: ctgIconSize,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
            Text(
              this.ctgName,
              style: TextStyle(
                color: Colors.white,
                fontSize: ctgFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
