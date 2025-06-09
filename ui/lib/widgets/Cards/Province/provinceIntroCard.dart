import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

class MyRadioOption<int> extends StatelessWidget {
  final int value;
  final int? groupValue;
  final String text;
  final String img;

  final ValueChanged<int?> onChanged;

  const MyRadioOption({
    required this.value,
    required this.groupValue,
    required this.text,
    required this.img,
    required this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return Container(
      width: 25,
      height: 25,
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: isSelected ? wPrimaryColor : Colors.white,
      ),
      child: Center(
          child: Icon(
        Icons.check_circle_rounded,
        size: 18,
        color: white,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.25,
      width: width * 0.40,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: height * 0.19,
            width: width * 0.40,
            decoration: BoxDecoration(
              color: wMagenta,
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: _buildLabel(),
          ),
          cardInfo(width, context),
          Container(
            height: height * 0.19 + 10,
            width: width * 0.40,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                splashColor: wPrimaryColor.withAlpha(80),
                onTap: () => {
                  onChanged(value),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned cardInfo(double width, context) {
    return Positioned(
      top: MediaQuery.of(context).size.longestSide * 0.19 - 30,
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minWidth: 100,
        ),
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              offset: Offset(0, 8),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.25),
            ),
          ], color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 14, fontFamily: wFont, fontWeight: wBoldWeight),
            ),
          ),
        ),
      ),
    );
  }
}
