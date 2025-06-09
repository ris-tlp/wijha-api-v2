// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/models/Locations/DestinationInterface.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/widgets/Cards/Destination/DestinationInfoCard.dart';
import 'package:wijha/widgets/Cards/Tours/tourCardList.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/widgets/Cards/Destination/DestinationCardList.dart';
import 'package:wijha/widgets/Tags/whiteCtg.dart';

class DestinationScreen extends StatefulWidget {
  final Destination destination;

  DestinationScreen({
    Key? key,
    required this.destination,
  }) : super(key: key);

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  Future<List<Destination>>? futureDestinations;
  Future<List<Location>>? futureLocations;
  List<Destination>? destinationList;
  late ImageProvider? image;
  bool loading = true;

  var textStyle =
      TextStyle(fontFamily: wFont, fontWeight: wBoldWeight, fontSize: 14);
  var textStyle2 = TextStyle(
      fontFamily: wFont,
      fontWeight: wBoldWeight,
      fontSize: 16,
      color: wPrimaryColor);

  @override
  void initState() {
    super.initState();
    if (widget.destination is Province) {
      // if (false) {
      futureDestinations =
          Province.fetchCitiesInProvince(widget.destination.name);
      futureDestinations!.then((data) => setState(() {
            destinationList = data;
          }));
    }
    if (widget.destination is City) {
      // destinationList = locationsList
      //     .where((location) => cityList[location.cityId] == widget.destination)
      //     .toList();
      futureLocations = City.fetchLocationsInCity(widget.destination.name);
      futureLocations!.then((data) => setState(() {
            destinationList = data;
          }));
    } else {
      destinationList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    // Wait for API to return data and change from loading to page
    if (destinationList != null) {
      setState(() {
        image = (widget.destination.imageNet
            ? NetworkImage(widget.destination.imageUrl)
                as ImageProvider<Object>?
            : AssetImage(
                widget.destination.imageUrl,
              ));
        loading = false;
      });
    }
    return loading
        ? Loading()
        : Scaffold(
            extendBody: true,
            backgroundColor: wBackgroundColor,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  imgSliderHeader(context, height, innerBoxIsScrolled),
                ];
              },
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    child: titleHeader(widget.destination, width),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: wDefaultPadding),
                        width: width,
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description ',
                              style: textStyle2,
                            ),
                          ),
                          descBox(),
                          SizedBox(height: 10),
                          if (widget.destination is City)
                            Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.destination is Province
                                    ? 'Cities'
                                    : widget.destination is City
                                        ? 'Locations'
                                        : 'Tours',
                                style: textStyle2,
                              ),
                            ),
                          if (widget.destination is City)
                            DestinationCarousel(
                                parent: widget.destination,
                                destinationList: destinationList!),
                          SizedBox(
                            height: 5,
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Container ctgSlider(double width, List<WCategory> ctgList) {
    return Container(
      width: width,
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

  imgSliderHeader(
      BuildContext context, double height, bool innerBoxIsScrolled) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverAppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          wLogo,
          color: white,
          height: 25,
        ),
        backgroundColor: wPurple,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            height: height * .4,
            child: Image(fit: BoxFit.cover, image: image!),
          ),
        ),
        expandedHeight: height * 0.40,
        collapsedHeight: 60,
        forceElevated: innerBoxIsScrolled,
      ),
    );
  }

  titleHeader(Destination destination, double width) {
    if (destination is Province)
      return Column(
        children: [
          Container(
            width: width,
            color: white,
            padding: EdgeInsets.symmetric(
                horizontal: wDefaultPadding, vertical: wDefaultPadding),
            child: Row(
              children: <Widget>[
                destinationWOrigin(destination, width),
              ],
            ),
          ),
          ctgSlider(width, []),
        ],
      );
    else
      return detailedHeader(destination, width);
  }

  destinationWOrigin(Destination destination, double width) {
    return Container(
      width: width - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TourTitle(title: destination.name),
          ),
        ],
      ),
    );
  }

  detailedHeader(Destination destination, double width) {
    if (destination is City)
      return Column(
        children: [
          Container(
            width: width,
            color: white,
            padding: EdgeInsets.symmetric(
                horizontal: wDefaultPadding, vertical: wDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TourTitle(title: destination.name),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(
                      locationIcon,
                      color: wPurple,
                      height: 12,
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        text: destination.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: wFont,
                            color: wPurple,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () => {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ctgSlider(width, destination.categories),
        ],
      );
    else if (destination is Location)
      return Column(
        children: [
          Container(
            width: width,
            color: white,
            padding: EdgeInsets.symmetric(
                horizontal: wDefaultPadding, vertical: wDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TourTitle(title: destination.name),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(
                      locationIcon,
                      color: wPurple,
                      height: 12,
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        text: destination.province,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: wFont,
                            color: wPurple,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Text(', ',
                        style: TextStyle(
                            fontSize: 15, fontFamily: wFont, color: wPurple)),
                    RichText(
                      text: TextSpan(
                        text: destination.city,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: wFont,
                            color: wPurple,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () => {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ctgSlider(width, destination.categories),
        ],
      );
  }

  descBox() {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(wDefaultPadding),
      child: Text(widget.destination.description, style: textStyle),
    );
  }
}

class DestinationCarousel extends StatelessWidget {
  final Destination parent;
  final List<Destination> destinationList;

  DestinationCarousel(
      {Key? key, required this.parent, required this.destinationList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: wDefaultPadding),
      width: 600,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () => destinationGridScreen(
                      context, parent, destinationList, height),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: wMagenta,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: wFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: height * .24,
              child: DestinationCardList(
                destinationList: destinationList,
                detailed: false,
              ))
        ],
      ),
    );
  }
}

destinationGridScreen(BuildContext context, Destination parent,
    List<Destination> destinationList, double height) {
  return showModalBottomSheet<void>(
    routeSettings: RouteSettings(name: '/modal'),
    isDismissible: false,
    barrierColor: wJetBlack.withOpacity(0.75),
    backgroundColor: wBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    isScrollControlled: true,
    elevation: 0,
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        top: false,
        child: Container(
          height: height * 0.95,
          child: DestinationGrid(
            parent: parent,
            destinationList: destinationList,
          ),
        ),
      );
    },
  );
}

class DestinationGrid extends StatelessWidget {
  final Destination parent;
  final List<Destination> destinationList;

  const DestinationGrid(
      {Key? key, required this.parent, required this.destinationList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

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
                      ctgSlider([], width),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height - 308,
                        child: Column(
                          children: [
                            DestinationCardList(destinationList: destinationList, scrollDirection: Axis.vertical, detailed: false, shrinkWrap: true,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          topBar(width, context),
        ],
      ),
    );
  }

  Container titleHeader(BuildContext context) {
    return Container(
      height: 88,
      color: white,
      padding: EdgeInsets.all(wDefaultPadding),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TourTitle(title: parent.name),
            ],
          ),
        ],
      ),
    );
  }

  Container ctgSlider(List<WCategory> ctgList, double width) {
    return Container(
      width: width,
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
                        Icons.location_city_rounded,
                        color: wGrey,
                        size: 25,
                      ),
                      SizedBox(width: 5),
                      Text(
                        destinationList is List<City> ? "Cities" : 'Locations',
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
}

class TourCarousel extends StatelessWidget {
  final List<Tour> tourList;

  TourCarousel({Key? key, required this.tourList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 600,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          //       GestureDetector(
          //         onTap: () => {
          //         },
          //         child: Text(
          //           'See all',
          //           style: TextStyle(
          //             color: wMagenta,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w400,
          //             fontFamily: wFont,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              height: height * .3,
              child: TourCardList(
                toursList: tourList,
              ))
        ],
      ),
    );
  }
}
