import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/provinceIntroCard.dart';
import 'package:wijha/widgets/constants.dart';

import '../../../providers/provinceProvider.dart';

class HeaderWithSearchBox extends ConsumerStatefulWidget {
  final Size size;

  const HeaderWithSearchBox({
    required this.size,
  });
  @override
  _HeaderWithSearchBox createState() => _HeaderWithSearchBox();
}

class _HeaderWithSearchBox extends ConsumerState<HeaderWithSearchBox> {
  int? _groupValue = 0;

  late PersistentBottomSheetController _controller; // <------ Instance variable
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(); // <---- Another instance variable

  ValueChanged<int?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  @override
  Widget build(BuildContext context) {
    final province = ref.watch(provinceProvider);
    int value = int.parse('12345');

    return Container(
      // It will cover 26% of our total height
      height: this.widget.size.longestSide * 0.26,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: wDefaultPadding,
              right: wDefaultPadding,
              bottom: 36 + wDefaultPadding,
            ),
            height: this.widget.size.longestSide * 0.25 - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              image: DecorationImage(
                image: province.imageUrl.contains('http://') || province.imageUrl.contains('https://') ? NetworkImage(
                  province.imageUrl,
                ) as ImageProvider :
                AssetImage(province.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: wDefaultPadding),
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: wPrimaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: wDefaultPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 18,
                      width: 18,
                      child: SvgPicture.asset(
                        locationIcon,
                        color: Colors.white,
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                    Text(
                      province.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingBar(context),
        ],
      ),
    );
  }

  Positioned floatingBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Row(
        children: [
          searchText(),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: wPrimaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ]),
            child: TextButton(
              onPressed: () {
                locationModalScreen(context);
              },
              child: SvgPicture.asset(
                saMapIcon,
                height: 40,
                color: white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  locationModalScreen(BuildContext context) async {
    return showModalBottomSheet<void>(
      barrierColor: wJetBlack.withOpacity(0.75),
      backgroundColor: wBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        final double height = MediaQuery.of(context).size.longestSide;
        final double width = MediaQuery.of(context).size.width;

        return SafeArea(
          child: Container(
            height: height * 0.95,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 60,
                    child: Container(
                      width: width,
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: wDefaultPadding),
                            SizedBox(
                              height: this.widget.size.longestSide,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 120),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    direction: Axis.horizontal,
                                    spacing: 5,
                                    children: [
                                      for (var i = 0;
                                          i < provinceData.length;
                                          i++) ...[
                                        MyRadioOption(
                                          value: i,
                                          groupValue: _groupValue,
                                          onChanged: _valueChangedHandler(),
                                          text: provinceData[i].name,
                                          img: provinceData[i].imageUrl,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    top: 0,
                    child: Container(
                      height: 60,
                      width: width,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: wDefaultPadding),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    saMapIcon,
                                    height: 25,
                                    color: wGrey,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Choose a Province To Explore',
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
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Container searchText() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: this.widget.size.width * 0.65,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.25),
            ),
          ]),
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: wDefaultPadding,
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: 18,
                width: 18,
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  color: wPrimaryColor,
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Explore other destination',
                    helperStyle: TextStyle(
                      fontFamily: wFont,
                      fontWeight: wRegularWeight,
                      color: wGrey,
                      fontSize: 16,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
