import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/radialProgress.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/roundImage.dart';
import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

import '../../../models/Users/Guide.dart';
import '../editProfile.dart';

class MyInfo extends StatelessWidget {
  final User user;
  final bool edit;

  MyInfo({
    required this.user, required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadialProgress(
            width: 5,
            progressBackgroundColor: Colors.black,
            goalCompleted: user.getProgress() / 1,
            child: RoundImage(
              imagePath: user.profilePicture,
              netImage: user.profilePicture.contains('http://') || user.profilePicture.contains('https://'),
              size: Size(170, 170),
            ),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                user is Guide ? user.userName + ', Certified' : user.userName,
                style: TextStyle(fontFamily: wFont, fontSize: 20, color: white,),
              ),
              // Text(
              //     ", Pro",
              //     style: TextStyle(fontFamily: wFont, fontSize: 25, color: white,)
              // ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              SvgPicture.asset("assets/icons/location.svg",
                  width: 11.0,
                  color: Colors.white,
                ),
                SizedBox(width: 5,),
                Text(
                  user.location,
                  style: TextStyle(fontFamily: wFont, fontSize: 15, color: white,),
                )
              ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (edit)
                Container(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                            builder: (context) =>
                        EditProfileScreen(user: user),
                        )
                        );},
                      icon: Icon(
                        Icons.edit,
                        color: white,
                      // ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
