import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as pod;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/screens/tour/bookingCnfrm.dart';
import 'package:wijha/screens/tour/tourLocationList.dart';
import 'package:wijha/widgets/Tags/incldItem.dart';
import 'package:wijha/widgets/Tags/whiteCtg.dart';
import 'package:wijha/widgets/constants.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multiselect_formfield/multiselect_formfield.dart';
// import 'package:wijha/models/Blogs/BlogPost.dart';
// import 'package:wijha/models/Forums/Subforum.dart';
// import 'package:wijha/models/Users/User.dart';
// import 'package:wijha/providers/authProvider.dart';
// import '../../models/Forums/ForumPost.dart';
// import '../../models/Forums/Tag.dart';
// import '../../models/Tours/Tour.dart';
// import '../../widgets/constants.dart';
// import '../../widgets/loading.dart';

class BookingScreen extends StatefulWidget {
  final Tour tour;
  const BookingScreen({
    Key? key,
    required this.tour,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  double _fee() {
    return this.widget.tour.price;
  }

  int _capacity() {
    return this.widget.tour.capacity;
  }

  List<TourInclude> _incld() {
    return this.widget.tour.included;
  }

  late String _totalPrice = _fee().toString();
  TextEditingController _controller = TextEditingController(text: '1');

  int _counter = 1;

  void _addPerson() {
    _counter = int.parse(_controller.text);
    setState(() {
      if (_counter < _capacity()) {
        _counter++;
        _totalPrice = (_fee() * _counter).toStringAsFixed(2);
      }
      _totalPrice = (_fee() * _counter).toStringAsFixed(2);
    });
  }

  void _rmvPerson() {
    _counter = int.parse(_controller.text);
    setState(() {
      if (_counter > 1) {
        _counter--;
        _totalPrice = (_fee() * _counter).toStringAsFixed(2);
      }
      _totalPrice = (_fee() * _counter).toStringAsFixed(2);
    });
  }

  void initState() {
    super.initState();
    _controller.text =
        _counter.toString(); // Setting the initial value for the field.
    _totalPrice = (_fee() * _counter).toStringAsFixed(2);
  }

  void _checkChange() {
    if (_controller.text == '') {
      _counter = 1;
    } else
      _counter = int.parse(_controller.text);
    setState(() {
      _totalPrice = (_fee() * _counter).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<WCategory> ctgList = this.widget.tour.categories;
    final double height = MediaQuery.of(context).size.longestSide;

    // return Consumer(builder: (context, ref, _) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: wPurple,
            centerTitle: true,
            title: Text("Tour Booking"),
          ),
          bottomNavigationBar: Container(
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
                Text('Total: ', style: TextStyle(fontFamily: wFont)),
                SizedBox(width: 10),
                Text(_totalPrice.toString() + ' SAR',
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
                      onPressed: () async {
                        try {
                          bool confirmed = await modalScreen(context, height);
                          if (confirmed) {
                            //// do it here
                            Navigator.pop(context, true);
                          }
                        } catch (exception) {}
                      },
                      child: Text('Proceed >',
                          style: TextStyle(
                              fontFamily: wFont,
                              fontWeight: wBlackWeight,
                              fontSize: 16,
                              color: white)),
                    )),
              ],
            ),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleHeader(context),
                ctgSlider(ctgList),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          color: white,
                          padding: const EdgeInsets.all(wDefaultPadding),
                          child: inputCounter(context)),
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
                                  text: _counter.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' = ' + _totalPrice.toString() + ' SAR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: wPrimaryColor)),
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
                ),
              ],
            ),
          )),
    );
  }

  modalScreen(BuildContext context, double height) {
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
            child: CnfrmBookingScreen(
              tour: this.widget.tour,
              participants: _counter,
              totalPrice: double.parse(_totalPrice),
            ),
          ),
        );
      },
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

  Column inputCounter(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Person: ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: wFont,
                  color: wJetBlack,
                )),
            Container(
              color: white,
              width: 40,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                maxLength: 2,
                onChanged: (value) => {
                  if (value == '0')
                    {_controller.text = '1'}
                  else if (value == '')
                    {value == '1'}
                  else if (int.parse(value) > _capacity())
                    {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                              title: Text(
                                'Maximum Capacity',
                                style: TextStyle(color: wPurple),
                              ),
                              content: Text(
                                  'The number of participants should not exceed the tour capacity'));
                        },
                      ),
                      _controller.text = _capacity().toString()
                    },
                  _checkChange(),
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                controller: _controller,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: wPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                  onPressed: () {
                    int currentValue;
                    if (_controller.text == '') {
                      _controller.text = '1';
                      currentValue = 1;
                    }
                    _rmvPerson();
                    currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue--;
                      _controller.text = (currentValue > 1 ? currentValue : 1)
                          .toString(); // decrementing value
                    });
                  },
                  child: Text('-',
                      style: TextStyle(
                          fontFamily: wFont,
                          fontWeight: wBoldWeight,
                          fontSize: 20,
                          color: white)),
                )),
            SizedBox(width: 5),
            Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: wPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                  onPressed: () {
                    int currentValue;
                    if (_controller.text == '') {
                      _controller.text = '0';
                      currentValue = 0;
                    }
                    _addPerson();
                    currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue++;
                      _controller.text = (currentValue <= _capacity()
                              ? currentValue
                              : _capacity())
                          .toString(); // d/ incrementing value
                    });
                  },
                  child: Text('+',
                      style: TextStyle(
                          fontFamily: wFont,
                          fontWeight: wBoldWeight,
                          fontSize: 20,
                          color: white)),
                )),
            SizedBox(width: wDefaultPadding),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('(Tour capacity : ' + _capacity().toString() + ')',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: wFont,
                  color: Colors.red,
                )),
          ],
        ),
      ],
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
