import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Forums/Tag.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/widgets/constants.dart';

class WhiteTag extends StatelessWidget {
  final Tag tag;

  const WhiteTag({
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
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              this.tag.imageUrl,
              color: wPurple,
              height: ctgIconSize,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
            Text(
              this.tag.title,
              style: TextStyle(
                color: wPurple,
                fontSize: ctgFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
