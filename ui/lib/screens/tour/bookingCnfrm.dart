import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/screens/tour/tourLocationList.dart';
import 'package:wijha/widgets/Tags/incldItem.dart';
import 'package:wijha/widgets/Tags/whiteCtg.dart';
import 'package:wijha/widgets/constants.dart';

class CnfrmBookingScreen extends StatefulWidget {
  final Tour tour;
  final int participants;
  final double totalPrice;

  const CnfrmBookingScreen({
    Key? key,
    required this.tour,
    required this.participants,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<CnfrmBookingScreen> createState() => _CnfrmBookingScreenState();
}

class _CnfrmBookingScreenState extends State<CnfrmBookingScreen> {
  double _fee() {
    return this.widget.tour.price;
  }

  double _totalPrice() {
    return this.widget.totalPrice;
  }

  int _participants() {
    return this.widget.participants;
  }

  List<TourInclude> _incld() {
    return this.widget.tour.included;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    final List<WCategory> ctgList = this.widget.tour.categories;
    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      final User user = _auth.getUser();
      return Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 60,
                child: Container(
                  width: width,
                  height: height - 180,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        titleHeader(context),
                        ctgSlider(ctgList),
                        priceCalc(),
                      ],
                    ),
                  ),
                )),
            topBar(width, context),
            bottomPriceBar(width, user),
          ],
        ),
      );
    });
  }

  Positioned topBar(double width, BuildContext context) {
    return Positioned(
        top: 0,
        child: Container(
          height: 60,
          width: width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: wDefaultPadding),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        color: wGrey,
                        size: 25,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Booking Confirmation",
                        style: TextStyle(
                            fontSize: 16,
                            color: wGrey,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: wGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: Icon(
                        Icons.close,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Positioned bottomPriceBar(double width, User user) {
    return Positioned(
        bottom: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: wDefaultPadding),
          height: 60,
          width: width,
          decoration: BoxDecoration(
            color: white,
            border: Border(
                top: BorderSide(
              color: wGrey,
              width: 0.1,
            )),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -5),
                blurRadius: 10,
                color: Colors.black.withOpacity(0.20),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Total: ', style: TextStyle(fontFamily: wFont)),
              SizedBox(width: 10),
              Text(_totalPrice().toString() + ' SAR',
                  style: TextStyle(
                      fontFamily: wFont,
                      fontWeight: wBoldWeight,
                      fontSize: 20,
                      color: wPrimaryColor)),
              SizedBox(width: 10),
              Container(
                  alignment: Alignment.center,
                  width: 125,
                  height: 40,
                  decoration: BoxDecoration(
                      color: wPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () {
                      // widget.tour.addRequest(_auth.getUser());
                      // print(widget.tour.registrationRequests);
                      this.widget.tour.registerTouristInTour(user);
                      Navigator.pop(context, true);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Confirm ',
                            style: TextStyle(
                                fontFamily: wFont,
                                fontWeight: wBlackWeight,
                                fontSize: 16,
                                color: white)),
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: white,
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  Container priceCalc() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(wDefaultPadding),
            color: Colors.grey[200],
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18.0,
                  color: wJetBlack,
                ),
                children: <TextSpan>[
                  TextSpan(text: _fee().toString()),
                  TextSpan(text: ' x '),
                  TextSpan(
                      text: _participants().toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: ' = ' + _totalPrice().toString() + ' SAR',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: wPrimaryColor)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(wDefaultPadding),
            child: Text(
              'Included: ',
              style: TextStyle(
                  fontFamily: wFont,
                  fontWeight: wBoldWeight,
                  fontSize: 16,
                  color: wPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: wDefaultPadding),
            child: inclBox(),
          ),
        ],
      ),
    );
  }

  Container inclBox() {
    return Container(
      alignment: Alignment.topLeft,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: [
          for (var i = 0; i < _incld().length; i++) ...[
            IcludedItem(item: _incld()[i]),
          ],
        ],
      ),
    );
  }

  Container ctgSlider(List<WCategory> ctgList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
            vertical: 10,
          ) +
          EdgeInsets.only(
            left: 10,
          ),
      decoration: BoxDecoration(
        gradient: wGradient,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          for (var i = 0; i < ctgList.length; i++) ...[
            WhiteCtg(ctg: ctgList[i]),
          ],
        ]),
      ),
    );
  }

  Container titleHeader(BuildContext context) {
    return Container(
      color: white,
      padding: EdgeInsets.all(wDefaultPadding),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .6,
                  child: TourTitle(title: this.widget.tour.title)),
              Padding(padding: EdgeInsets.only(top: 2)),
              Row(
                children: [
                  SvgPicture.asset(
                    locationIcon,
                    color: wPurple,
                    height: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    this.widget.tour.city.province +
                        ', ' +
                        this.widget.tour.city.name,
                    style: TextStyle(color: wPurple),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      this.widget.tour.destinations.length.toString(),
                      style: TextStyle(
                          color: wPrimaryColor,
                          fontFamily: wFont,
                          fontWeight: wBoldWeight,
                          fontSize: 18),
                    ),
                    SizedBox(width: 5),
                    Container(
                      height: 41,
                      width: 41,
                      margin: EdgeInsets.only(right: wDefaultPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            white,
                            wBackgroundColor,
                          ],
                        ),
                        border: Border.all(color: wPrimaryColor, width: 1.1),
                      ),
                      child: TextButton(
                        onPressed: () {
                          locationModalScreen(
                              context, MediaQuery.of(context).size.longestSide);
                        },
                        child: SvgPicture.asset(
                          plannerIcon,
                          color: wPrimaryColor,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  locationModalScreen(BuildContext context, double height) {
    return showModalBottomSheet<void>(
      isDismissible: false,
      barrierColor: wJetBlack.withOpacity(0.75),
      backgroundColor: wBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          child: Container(
            height: height * 0.95,
            child: TourLocationList(
              tour: widget.tour,
            ),
          ),
        );
      },
    );
  }
}
