import 'package:flutter/material.dart';
import 'package:wijha/models/Forums/Tag.dart';
import 'package:wijha/widgets/constants.dart';

class WTag extends StatelessWidget {
  final Tag tag;

  const WTag({
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
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: wJetBlack.withOpacity(0.6),
            borderRadius: BorderRadius.circular(50)),
        child: Text(
          this.tag.getTitle,
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
