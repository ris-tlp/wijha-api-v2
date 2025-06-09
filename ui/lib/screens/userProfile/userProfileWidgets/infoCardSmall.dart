import 'package:wijha/screens/userProfile/userProfileWidgets/twoLineItem.dart';
import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final firstText, secondText, hasImage, imagePath;

  const ProfileInfoCard({Key? key, this.firstText, this.secondText, this.hasImage = false, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: hasImage
            ? Center(
              child: Image.asset(
                  imagePath,
                  width: 35,
                ),
            )
            : TwoLineItem(
                firstText: firstText,
                secondText: secondText,
              ),
      ),
    );
  }
}
