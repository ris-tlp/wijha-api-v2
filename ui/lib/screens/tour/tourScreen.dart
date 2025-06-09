import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Tours/Review.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/models/Users/Tourist.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/screens/tour/booking.dart';
import 'package:wijha/widgets/Tags/incldItem.dart';
import 'package:wijha/widgets/Tags/whiteCtg.dart';
import 'package:wijha/widgets/constants.dart';

import 'tourLocationList.dart';

class TourScreen extends ConsumerStatefulWidget {
  final Tour tour;
  final bool disabled;
  const TourScreen({
    Key? key,
    required this.tour,
    this.disabled = false,
  }) : super(key: key);

  @override
  ConsumerState<TourScreen> createState() {
    return _TourScreen();
  }
}

class _TourScreen extends ConsumerState<TourScreen>
    with SingleTickerProviderStateMixin {
  int _current = 0;

  double _price() {
    return this.widget.tour.price;
  }

  List<TourInclude> _incld() {
    return this.widget.tour.included;
  }

  String _desc() {
    return this.widget.tour.description;
  }

  DateTime _time() {
    return this.widget.tour.dateTime;
  }

  var textStyle =
      TextStyle(fontFamily: wFont, fontWeight: wBoldWeight, fontSize: 14);
  var textStyle2 = TextStyle(
      fontFamily: wFont,
      fontWeight: wBoldWeight,
      fontSize: 16,
      color: wPrimaryColor);

  late bool disabled;

  @override
  initState() {
    super.initState();
    bool registered = false;
    //
    // for (Request request in widget.tour.registrationRequests) {
    //   if (request.user == tourist) registered = true;
    // }

    if (registered) {
      disabled = true;
    } else {
      disabled = widget.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = this.widget.tour.images;
    final List<WCategory> ctgList = this.widget.tour.categories;

    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: bookingBar(),
          backgroundColor: wBackgroundColor,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                imgSliderHeader(context, height, imgList, innerBoxIsScrolled),
              ];
            },
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 60),
                  child: Column(children: <Widget>[
                    titleHeader(height, width),
                    ctgSlider(width, ctgList),
                    tabsNav(textStyle, width),
                  ]),
                ),
                tabsBody(width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container titleHeader(double height, double width) {
    return Container(
      width: width,
      color: white,
      padding: EdgeInsets.symmetric(
          horizontal: wDefaultPadding, vertical: wDefaultPadding),
      child: Row(
        children: <Widget>[
          titleWCity(width),
          mapBtn(height),
        ],
      ),
    );
  }

  Container mapBtn(double height) {
    return Container(
      child: Expanded(
        child: Row(
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
                  locationModalScreen(context, height);
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
      ),
    );
  }

  Container titleWCity(double width) {
    return Container(
      width: width * .65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TourTitle(title: this.widget.tour.title),
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
                  text: this.widget.tour.city.province,
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
                  text: this.widget.tour.city.name,
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
    );
  }

  Expanded tabsBody(double width) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: wDefaultPadding),
            width: width,
            child: TabBarView(
              children: [
                descriptionTab(),
                reviewsTab(),
                guideTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView guideTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      foregroundImage: widget.tour.guide.netImage
                          ? NetworkImage(widget.tour.guide.profilePicture)
                              as ImageProvider
                          : AssetImage(widget.tour.guide.profilePicture),
                      backgroundColor: wPrimaryColor,
                      radius: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Text(
                              widget.tour.guide.userName,
                              style: TextStyle(
                                  color: wPurple,
                                  fontSize: 18,
                                  fontWeight: wBlackWeight,
                                  letterSpacing: .4),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Row(
                            children: <Widget>[
                              Text(
                                'Local Guide',
                                style: TextStyle(color: wJetBlack),
                              ),
                              SizedBox(width: 15),
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      widget.tour.guide.profilePicture,
                                      color: Colors.orange,
                                      height: 13,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2)),
                                    Text(
                                      this.widget.tour.guide.rating.toString(),
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1)),
                                    Text(
                                      '(8)',
                                      style: TextStyle(
                                        color: wGrey,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.info_outlined,
                  color: wPrimaryColor,
                  size: 22,
                ),
                SizedBox(width: 5),
                Text(
                  'About me ',
                  style: textStyle2,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(wDefaultPadding),
            child: Column(
              children: [
                Text(widget.tour.guide.about),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(wDefaultPadding),
            margin: EdgeInsets.only(top: wDefaultPadding),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.map_sharp,
                  color: wPrimaryColor,
                  size: 22,
                ),
                SizedBox(width: 5),
                Text(
                  'Tour Guide In:',
                  style: textStyle2,
                ),
                SizedBox(width: 10),
                Text(
                  widget.tour.guide.location,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(wDefaultPadding),
            margin: EdgeInsets.only(top: wDefaultPadding),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.language_sharp,
                  color: wPrimaryColor,
                  size: 22,
                ),
                SizedBox(width: 5),
                Text(
                  'Languages:',
                  style: textStyle2,
                ),
                SizedBox(width: 10),
                Text(
                  'Arabic , English',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView reviewsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Ratings',
              style: textStyle2,
            ),
          ),
          Container(
            width: 600,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(wDefaultPadding),
            child: RatingBarIndicator(
              rating: widget.tour.rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              unratedColor: Colors.amber.withAlpha(50),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Comments',
              style: textStyle2,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.tour.reviews.length,
            itemBuilder: (context, index) {
              Review review = widget.tour.reviews[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: 600,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: CircleAvatar(
                                maxRadius: 15,
                                backgroundImage: review.user.netImage
                                    ? NetworkImage(review.user.profilePicture)
                                        as ImageProvider
                                    : AssetImage(
                                        review.user.profilePicture,
                                      ),
                              ),
                            ),
                            Text(
                              review.user.userName,
                              style: TextStyle(
                                fontFamily: wFont,
                                fontSize: 14,
                                fontWeight: wBoldWeight,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: RatingBarIndicator(
                                rating: review.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 20,
                                itemCount: 5,
                                unratedColor: Colors.amber.withAlpha(50),
                              ),
                            ),
                          ],
                        ),
                        review.comment != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            review.comment,
                            style: TextStyle(
                              fontFamily: wFont,
                              color: wJetBlack,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  SingleChildScrollView descriptionTab() {
    DateTime timeNdate = _time();
    String dateStr = timeNdate.day.toString() +
        ('/') +
        timeNdate.month.toString() +
        ('/') +
        timeNdate.year.toString();

    String timeStr =
        timeNdate.hour.toString() + (':') + timeNdate.minute.toString();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Date and Time ',
              style: textStyle2,
            ),
          ),
          timeBox(dateStr, timeStr),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Description ',
              style: textStyle2,
            ),
          ),
          descBox(),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              'What' + "'" + 's Included',
              style: textStyle2,
            ),
          ),
          inclBox(),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  SliverOverlapAbsorber imgSliderHeader(BuildContext context, double height,
      List<String> imgList, bool innerBoxIsScrolled) {
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
          background: imageSlider(height, imgList),
        ),
        expandedHeight: height * 0.40,
        collapsedHeight: 60,
        forceElevated: innerBoxIsScrolled,
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

  Container descBox() {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(wDefaultPadding),
      child: Column(
        children: [Text(_desc(), style: textStyle)],
      ),
    );
  }

  Container timeBox(String date, String time) {
    return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(wDefaultPadding),
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today_rounded,
                    color: wPurple,
                    size: 20.0,
                  ),
                  SizedBox(width: 8),
                  Text(
                    date,
                    style: TextStyle(
                      color: wPurple,
                      fontFamily: wFont,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: wPurple,
                    size: 20.0,
                  ),
                  SizedBox(width: 8),
                  Text(
                    time,
                    style: TextStyle(
                      color: wPurple,
                      fontFamily: wFont,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Container tabsNav(
    TextStyle textStyle,
    double width,
  ) {
    return Container(
      height: 40,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: wDefaultPadding),
      decoration: BoxDecoration(
        color: white,
      ),
      child: TabBar(
        tabs: [
          Tab(
            child: Text(
              'Description',
              style: textStyle,
            ),
          ),
          Tab(
            child: Text(
              'Reviews',
              style: textStyle,
            ),
          ),
          Tab(
            child: Text(
              'Tour Guide',
              style: textStyle,
            ),
          ),
        ],
        labelColor: wPrimaryColor,
        indicatorColor: wPrimaryColor,
        indicatorWeight: 3,
        unselectedLabelColor: wGrey,
        automaticIndicatorColorAdjustment: true,
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

  Builder imageSlider(double height, List<String> imgList) {
    return Builder(builder: (context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: height * 0.40,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imgList
                  .map(
                    (item) => Container(
                      child: Center(
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Positioned(bottom: 5, child: sliderIndicator(imgList, context)),
        ],
      );
    });
  }

  Container bookingBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: wDefaultPadding),
      height: 60,
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
          Text(_price().toString() + ' SAR',
              style: TextStyle(
                  fontFamily: wFont,
                  fontWeight: wBoldWeight,
                  fontSize: 20,
                  color: wPrimaryColor)),
          Text(' / Person ', style: TextStyle(fontFamily: wFont)),
          SizedBox(width: 10),
          Consumer(builder: (context, ref, _) {
            final _auth = ref.watch(userProvider.notifier);
            final user = _auth.getUser();

            for (Request request in widget.tour.registrationRequests) {
              if (request.user == user) disabled = true;
            }

            return (!disabled &&
                    !(widget.tour.guide == user) &&
                    !(widget.tour.registrationRequests
                        .map((registration) => registration.user)
                        .contains(user)) &&
                    user is Tourist)
                ? TextButton(
                    onPressed: () async {
                      bool registered =
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (C) => BookingScreen(
                                    tour: this.widget.tour,
                                  )));

                      if (registered) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: 'Tour Registered Successfully');
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 125,
                      height: 40,
                      decoration: BoxDecoration(
                          color: wPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text('Book Now >',
                          style: TextStyle(
                              fontFamily: wFont,
                              fontWeight: wBlackWeight,
                              fontSize: 16,
                              color: white)),
                    ),
                  )
                : TextButton(
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: 125,
                      height: 40,
                      decoration: BoxDecoration(
                          color: wGrey,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text('Disabled',
                          style: TextStyle(
                              fontFamily: wFont,
                              fontWeight: wBlackWeight,
                              fontSize: 16,
                              color: white)),
                    ),
                  );
          })
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

  Row sliderIndicator(List<String> imgList, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (white).withOpacity(_current == entry.key ? 1 : 0.4)),
          ),
        );
      }).toList(),
    );
  }
}
