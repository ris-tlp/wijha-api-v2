// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/City.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/screens/Province/provinceWidgets/CityCarousel.dart';
import 'package:wijha/widgets/LocationAbout.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import 'provinceWidgets//provinceHeader.dart';

@Deprecated('Use DestinationScreen instead')
class ProvinceScreen extends StatefulWidget {
  final Province province;

  ProvinceScreen({
    Key? key,
    required this.province,
  }) : super(key: key);

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  Future<List<City>>? futureCities;
  List<City>? cityList;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    futureCities = Province.fetchCitiesInProvince(widget.province.name);
    // futureCities = fetchCitiesInProvince("xd");
    futureCities!.then((data) => setState(() {
          cityList = data;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    // Wait for API to return data and change from loading to page
    if (cityList != null) {
      setState(() {
        loading = false;
      });
    }
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(children: <Widget>[
                      ProvinceHeader(
                        provinceImage: widget.province.imageUrl,
                        province: widget.province.name,
                      ),
                      Column(
                        children: [
                          SizedBox(height: 5),
                          LocationAbout(
                              description: widget.province.description),
                          SizedBox(height: 5),
                          CityCarousel(cityList: cityList!),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ]),
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
