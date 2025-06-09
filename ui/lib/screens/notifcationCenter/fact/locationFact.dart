import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/widgets/constants.dart';

class LocationFact extends StatefulWidget {
  final Fact fact;

  const LocationFact({
    Key? key,
    required this.fact,
  }) : super(key: key);

  @override
  State<LocationFact> createState() => _LocationFactState();
}

class _LocationFactState extends State<LocationFact> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    locationIcon,
                    color: wPrimaryColor,
                    height: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: wDefaultPadding, bottom: wDefaultPadding),
                  child: Container(
                    height: height * .45,
                    width: width * .85,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: wGrey,
                        width: .5,
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: wGrey,
                      //     offset: Offset(1.75, 2)
                      //   ),
                      // ],
                    ),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(wDefaultPadding),
                        child: Text(
                          this.widget.fact.content,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: wFont,
                            letterSpacing: .75,
                            // fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ]
            ),
            IconButton(
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
          ],
        ),
      ),
    );
  }
}
