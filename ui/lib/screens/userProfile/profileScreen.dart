import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/Tourist.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/tourProvider.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/userInfo.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/opaqueImage.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/infoCardLarge.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/infoCardSmall.dart';
import 'package:flutter/material.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/infoCardLarge.dart';
import 'package:wijha/widgets/constants.dart';

import '../../models/Tours/Tour.dart';
import '../../models/Users/User.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final User user;

  ProfileScreen({
    required this.user,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, ref, _)
    {
      List<Tour> tours = ref.watch(tourProvider.notifier).getTours();
      final _auth = ref.watch(userProvider.notifier);

      if (widget.user is Tourist)
        tours = tours.where((tour) => tour.attendance.contains(widget.user)).toList();
      else if (widget.user is Guide) {
        tours = tours.where((tour) => tour.guide == widget.user).toList();
      }

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Container(
              height: 25,
              child: Icon(
                Icons.arrow_back,
                color: wJetBlack,
              ),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: <Widget>[
                      OpaqueImage(
                        imageUrl: "assets/images/Ithra.jpg",
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              MyInfo(user: widget.user, edit: widget.user == _auth.getUser()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.only(top: 80),
                    color: Colors.white,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            ProfileInfoBigCard(
                              firstText: widget.user.travelPoints.toString(),
                              secondText: "Travel Points",
                              icon: Icon(
                                Icons.stars,
                                size: 32,
                                color: wPrimaryColor,
                              ),
                            ),
                            ProfileInfoBigCard(
                              firstText: tours.length.toString(),
                              secondText: "Tours",
                              icon: Icon(
                                Icons.map,
                                size: 32,
                                color: wPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            ProfileInfoBigCard(
                              firstText: "12",
                              secondText: "Blog Posts",
                              icon: Icon(
                                Icons.terrain,
                                size: 32,
                                color: wPrimaryColor,
                              ),
                            ),
                            GestureDetector(
                              // onTap: () {
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (context) => SuperLikesMePage(),
                              //     ),
                              //   );
                              // },
                              child: ProfileInfoBigCard(
                                firstText: "264",
                                secondText: "Interactions",
                                icon: Icon(
                                  Icons.favorite,
                                  size: 32,
                                  color: wPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: screenHeight * (5 / 12),
              left: 16,
              right: 16,
              child: Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ProfileInfoCard(firstText: widget.user.getLevel(), secondText: "Level"),
                    SizedBox(
                      width: 10,
                    ),
                    ProfileInfoCard(
                      hasImage: true,
                      imagePath: "assets/logos/sus_logo.jpg",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ProfileInfoCard(firstText: (widget.user.getProgress()).toString() + "%", secondText: "Progress"),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
