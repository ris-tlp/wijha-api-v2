import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/widgets/constants.dart';
import 'CityCardGrid.dart';

class AllCityScreen extends StatelessWidget {
  final List<City> cityList;

  AllCityScreen({Key? key, required this.cityList}) : super(key: key);

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
      body: SafeArea(child: CityCardGrid(cityList: cityList)),
    );
  }
}
