import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/widgets/constants.dart';

class IcludedItem extends StatelessWidget {
  final TourInclude item;

  const IcludedItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            item.icon,
            color: wPrimaryColor,
            height: 25,
          ),
          SizedBox(height: 10),
          Text(
            item.item,
            style: TextStyle(color: wGrey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
