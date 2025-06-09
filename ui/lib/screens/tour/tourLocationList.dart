import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/widgets/Cards/Destination/DestinationCardList.dart';

import '../../models/Tours/Category.dart';
import '../../models/Tours/Tour.dart';
import '../../models/Tours/tourInclude.dart';
import '../../widgets/Tags/incldItem.dart';
import '../../widgets/Tags/whiteCtg.dart';
import '../../widgets/constants.dart';

class TourLocationList extends StatefulWidget {
  final Tour tour;

  const TourLocationList({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourLocationList> createState() => _TourLocationListState();
}

class _TourLocationListState extends State<TourLocationList> {

  List<TourInclude> _incld() {
    return this.widget.tour.included;
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    final List<WCategory> ctgList = this.widget.tour.categories;

    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 60,
              child: Container(
                width: width,
                height: height - 60,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      titleHeader(context),
                      ctgSlider(ctgList),
                      Container(height: height - 228, child: DestinationCardList(scrollDirection: Axis.vertical, destinationList: widget.tour.destinations, detailed: false,))
                    ],
                  ),
                ),
              )),
          topBar(width, context),
        ],
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
                      SvgPicture.asset(
                        plannerIcon,
                        color: wGrey,
                        height: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "On This Tour",
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
              TourTitle(title: this.widget.tour.title),
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
        ],
      ),
    );
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
                  TextSpan(text: ' x '),
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
}
