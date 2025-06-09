import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/widgets/constants.dart';

class SearchBar extends StatelessWidget {
  final Size size;

  const SearchBar({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // It will cover 26% of our total height
      height: this.size.longestSide * 0.1,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          searchText(),
        ],
      ),
    );
  }

  Container searchText() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: this.size.width * 0.65,
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
                    hintText: 'Search fourms',
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
