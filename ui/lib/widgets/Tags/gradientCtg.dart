import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/widgets/constants.dart';

class GradientCtg extends StatelessWidget {
  final WCategory ctg;

  const GradientCtg({
    Key? key,
    required this.ctg,
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
              this.ctg.icon,
              color: Colors.white,
              height: ctgIconSize,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
            Text(
              this.ctg.title,
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
