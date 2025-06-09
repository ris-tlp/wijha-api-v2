import 'package:flutter/material.dart';

import '../../../widgets/constants.dart';

class TwoLineItem extends StatelessWidget {
  final String firstText, secondText;

  const TwoLineItem({Key? key, required this.firstText, required this.secondText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          firstText,
          style: TextStyle(fontFamily: wFont, fontSize: 25),
        ),
        Text(
          secondText,
          style: TextStyle(fontFamily: wFont, fontSize: 18, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
