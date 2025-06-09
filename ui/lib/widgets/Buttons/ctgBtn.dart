import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/widgets/constants.dart';

class CtgBtn extends StatelessWidget {
  final WCategory category;

  const CtgBtn({
    Key? key,
    required this.category,
  }) : super(key: key);

  final double btnSize = 45;
  final double verMargin = 5;
  final double horMargin = 10;
  final double borderRadius = 15;
  final double ctgIconSize = 25;
  final double ctgFontSize = 14;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: wPrimaryColor.withAlpha(80),
          onTap: () => {},
          child: Container(
            height: btnSize,
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: <Widget>[
                Container(
                  height: btnSize,
                  width: btnSize,
                  decoration: BoxDecoration(
                    gradient: wGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    this.category.icon,
                    color: white,
                    height: 22,
                    fit: BoxFit.none,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  this.category.title,
                  style: TextStyle(
                    color: wPrimaryColor,
                    fontSize: ctgFontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
