import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/widgets/constants.dart';

class CtgItem extends StatelessWidget {
  final String icon;
  final String ctgName;
  final String dest;

  const CtgItem({
    Key? key,
    required this.icon,
    required this.ctgName,
    required this.dest,
    action,
  }) : super(key: key);

  final double btnSize = 55;
  final double verMargin = 5;
  final double horMargin = 10;
  final double borderRadius = 15;
  final double ctgIconSize = 25;
  final double ctgFontSize = 14;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: btnSize,
          width: btnSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                wPrimaryColor,
                wPurple,
              ],
            ),
          ),
          child: TextButton(
            onPressed: () {},
            child: SvgPicture.asset(
              this.icon,
              color: Colors.white,
              height: ctgIconSize,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: horMargin),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: verMargin),
          child: Text(
            this.ctgName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ctgFontSize,
              color: wPurple,
            ),
          ),
        ),
      ],
    );
  }
}
