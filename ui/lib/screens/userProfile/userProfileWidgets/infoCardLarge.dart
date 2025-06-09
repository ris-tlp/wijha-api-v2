import 'package:flutter/material.dart';

import '../../../widgets/constants.dart';

class ProfileInfoBigCard extends StatelessWidget {
  final String firstText, secondText;
  final Widget icon;

  const ProfileInfoBigCard({Key? key, required this.firstText, required this.secondText, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 10,
          bottom: 24,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: icon,
            ),
            Text(firstText, style: TextStyle(fontFamily: wFont, fontSize: 25,),),
            Text(secondText,style: TextStyle(fontFamily: wFont, fontSize: 18, fontWeight: FontWeight.w300),),
          ],
        ),
      ),
    );
  }
}
