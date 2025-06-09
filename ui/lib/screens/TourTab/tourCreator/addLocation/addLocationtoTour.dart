import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import '../../../../widgets/constants.dart';
import 'addCustomLocationtoTour.dart';
import 'addWijhaLocationtoTour.dart';

class AddLocation extends StatelessWidget {
  final List<Location> locations;
  final List<Fact> facts;

  const AddLocation({
    Key? key,
    required this.locations,
    required this.facts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: white,
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
      body: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AddLocationCardButton(
              title: 'Wijha Locations',
              target: AddWijhaLocation(
                locations: this.locations,
                facts: this.facts,
              ),
              locations: this.locations,
              facts: this.facts,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: wGrey,
                    height: height * .08,
                    indent: wDefaultPadding,
                    endIndent: 12.5,
                    thickness: 1.2,
                  ),
                ),
                Text(
                  'OR',
                  style: TextStyle(
                    fontFamily: wFont,
                    color: wGrey,
                    fontSize: 18,
                    fontWeight: wLightWeight,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: wGrey,
                    height: height * .08,
                    indent: 12.5,
                    endIndent: wDefaultPadding,
                    thickness: 1.2,
                  ),
                ),
              ],
            ),
            AddLocationCardButton(
              title: 'Custom Locations',
              target: AddCustomLocation(
                locations: locations,
                facts: this.facts,
              ),
              locations: this.locations,
              facts: this.facts,
            )
          ],
        ),
      ),
    );
  }
}

class AddLocationCardButton extends StatelessWidget {
  final String title;
  final Widget target;
  final List<Location> locations;
  final List<Fact> facts;

  const AddLocationCardButton({
    Key? key,
    required this.title,
    required this.target,
    required this.locations,
    required this.facts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => awaitResponse(context),
      child: Container(
        width: width * .9,
        height: height * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: wCardButtonGradient,
          boxShadow: [
            BoxShadow(
              color: wJetBlack,
              blurRadius: 4.5,
            )
          ],
        ),
        child: Center(
          child: Text(
            this.title,
            style: TextStyle(
              fontFamily: wFont,
              color: white,
              fontSize: 38,
              fontWeight: wBoldWeight,
            ),
          ),
        ),
      ),
    );
  }

  void awaitResponse(BuildContext context) async {
    final List selected = await (Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => target),
    ));
    Navigator.pop(context, selected);
  }
}
