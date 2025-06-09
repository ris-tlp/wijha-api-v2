import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/models/Locations/DestinationInterface.dart';
import 'package:wijha/models/Locations/Location.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/screens/Province/provinceScreen.dart';
import '../../../screens/destination/destinationScreen.dart';
import '../../constants.dart';

class DestinationInfoCard extends StatelessWidget {
  final Destination destination;
  final bool detailed;
  final bool vertical;

  DestinationInfoCard({
    Key? key,
    required this.destination,
    this.detailed = true,
    this.vertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    final ImageProvider? image = (destination.imageNet ?
    NetworkImage(destination.imageUrl) as ImageProvider<Object>?
        :
    AssetImage(destination.imageUrl,));

    return GestureDetector(
      onTap: () => goto(context, destination),
      child: Container(
        height: detailed ? height * 0.28 : height * .2,
        width: vertical ? width : width * .5,
        margin: vertical ? EdgeInsets.symmetric(vertical: .5) : EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: height * 0.18,
                width: vertical ? width : width * .5,
                decoration: BoxDecoration(
                  color: wPrimaryColor,
                  borderRadius: vertical ? BorderRadius.circular(.5) : BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: vertical ? BorderRadius.circular(.5) : BorderRadius.circular(15),
                  child: Image(
                    // width: width,
                    image: image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                top: height * 0.18 - 30,
                child:
                Container(
                  height: detailed ? 90 : 30,
                  width: vertical ? width * .8 : width * .4,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 8),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: getDestinationInfo(destination, width),
                ),
            ),
          ],
        ),
      ),
    );
  }

  getDestinationInfo(Destination destination, width) {
    if (destination is Province)
      return Column(
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
                gradient: wGradient,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))
            ),
            alignment: Alignment.center,
            child: Text(
              destination.name,
              style: TextStyle(
                fontFamily: wFont,
                color: white,
                fontWeight: wBoldWeight,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * .025),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
              ),
              child: Text(
                destination.description,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: wFont,
                  color: wJetBlack,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      );
    else if (destination is City)
      return Column(
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
                gradient: wGradient,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))
            ),
            alignment: Alignment.center,
            child: Text(
              destination.name,
              style: TextStyle(
                fontFamily: wFont,
                color: white,
                fontWeight: wBoldWeight,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * .025),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
              ),
              child: Text(
                destination.description,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: wFont,
                  color: wJetBlack,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      );
    else if (destination is Location)
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.5),
            height: 30,
            decoration: BoxDecoration(
                gradient: wGradient,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))
            ),
            alignment: Alignment.center,
            child: Text(
              destination.name,
              style: TextStyle(
                fontFamily: wFont,
                color: white,
                fontWeight: wBoldWeight,
                fontSize: vertical ? 18 : 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * .025),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
              ),
              child: Text(
                destination.description,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: wFont,
                  color: wJetBlack,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      );
  }

  goto(BuildContext context, Destination destination) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => DestinationScreen(destination: destination,)));
  }
}
