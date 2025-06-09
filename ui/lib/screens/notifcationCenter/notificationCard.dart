import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Notifications/Fact.dart';
import 'package:wijha/models/Notifications/NotificationModel.dart';
import 'package:wijha/screens/notifcationCenter/fact/locationFact.dart';
import 'package:wijha/widgets/constants.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;

  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return getCard(context, widget.notification);
  }

  Widget getCard(context, NotificationModel notification) {
    if (notification is Fact) {
      return locationFactCard(context, notification);
    } else {
      throw {};
    }
  }

  Widget locationFactCard(context, Fact fact) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => LocationFact(fact: fact))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          height: height * 0.125,
          // width: width * 0.48,
          width: width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: wGrey, blurRadius: 1.5, spreadRadius: .25),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                locationIcon,
                color: wMagenta,
                height: 32,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Location Fact: ",
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 1.2,
                            fontFamily: wFont,
                            color: wMagenta,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          fact.location.name,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 1.2,
                            fontFamily: wFont,
                            color: wMagenta,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: width * .75,
                    child: Text(
                      widget.notification.content,
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.2,
                        fontFamily: wFont,
                        color: wJetBlack,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
