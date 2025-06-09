import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Users/Tourist.dart';
import 'package:wijha/screens/TourTab/tourTabWidgets/cardButton.dart';
import 'package:wijha/screens/tour/QR/qrscannerTourist.dart';
import 'package:wijha/screens/tourTab/tourist/history/history.dart';
import 'package:wijha/screens/tourTab/tourist/registered/registered.dart';

import '../../../providers/authProvider.dart';
import '../../../widgets/constants.dart';
import '../../signUpIn/signUpIn.dart';

class TouristTourScreen extends StatefulWidget {
  @override
  State<TouristTourScreen> createState() => _TouristTourScreen();
}

class _TouristTourScreen extends State<TouristTourScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, _) {
          final _auth = ref.watch(userProvider.notifier);
          if (_auth.getUser() is Tourist) {
            return GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .65,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              children: [
                CardButton(
                    text: 'Registered',
                    icon: Icons.app_registration_rounded,
                    target: RegisteredTours()),
                CardButton(
                    text: 'History',
                    icon: Icons.history_edu_rounded,
                    target: History(tours: tourist.tourHistoryList)),
                CardButton(
                  text: 'QR Scanner',
                  icon: Icons.qr_code_rounded,
                  target: QRScannerTourist(),
                ),
              ],
            );
          } else {
            return InkWell(
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpIn())),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: wGradient,
                ),
                child: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width * .7,child: Text('Sign in to see your active tours', textAlign: TextAlign.center, style: TextStyle(color: white, fontWeight: wBoldWeight, fontFamily: wFont, fontSize: 28),))
              ),
            );
          }
        }),
      ),
    );
  }
}
