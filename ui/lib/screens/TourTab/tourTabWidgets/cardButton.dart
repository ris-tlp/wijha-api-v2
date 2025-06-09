import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wijha/widgets/constants.dart';

class CardButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Widget target;

  CardButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.target,
  }) : super(key: key);

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => this.widget.target)),
      child: Container(
        height: 190,
        width: width * .3,
        decoration: BoxDecoration(
            gradient: wCardButtonGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: wGrey,
                blurRadius: 3,
                spreadRadius: .5,
              ),
            ]
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(7.5),
              width: width * .3,
              child: Text(
                this.widget.text,
                style: TextStyle(
                  color: white,
                  fontFamily: wFont,
                  fontWeight: wRegularWeight,
                  fontSize: 16,
                ),
              ),
            ),
            Center(
              child: Icon(
                widget.icon,
                size: 60,
                color: white,
              )
            ),
          ],
        ),
      ),
    );
  }
}
