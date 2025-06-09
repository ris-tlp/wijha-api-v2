import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Notifications/NotificationModel.dart';
import 'package:wijha/widgets/constants.dart';

import 'notificationCard.dart';

class NotificationScreen extends StatefulWidget {
  final List<NotificationModel> notificationList;

  const NotificationScreen({
    Key? key,
    required this.notificationList,
  }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListView.builder(
            itemCount: this.widget.notificationList.length,
            itemBuilder: (BuildContext context, int index) {
              NotificationModel not = this.widget.notificationList[index];
              return NotificationCard(notification: not);
            },
          ),
        ),
      ),
    );
  }
}
