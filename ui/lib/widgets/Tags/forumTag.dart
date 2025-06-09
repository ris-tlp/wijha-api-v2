import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

class WfroumTag extends StatelessWidget {
  final String tag;

  const WfroumTag({
    Key? key,
    required this.tag,
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
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
            gradient: wGradient, borderRadius: BorderRadius.circular(50)),
        child: Text(
          this.tag,
          style: TextStyle(
            fontFamily: wFont,
            color: white,
            fontSize: ctgFontSize,
          ),
        ),
      ),
    );
  }
}
