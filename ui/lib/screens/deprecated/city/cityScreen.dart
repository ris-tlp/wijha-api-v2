import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/screens/home/homeWidgets/tourCard.dart';
import 'package:wijha/screens/tour/tourWidgets/tourCtg.dart';

import '../../../widgets/Cards/Location/LocationCard.dart';

@Deprecated('Use DestinationScreen instead')
class CityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // HeaderWithTag(
              //   size: size,
              //   cityImage: 'assets/images/khobar.jpg',
              //   city: 'Khobar',
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TourCtg(
                      icon: adventureIcon,
                      ctgName: 'Adventure',
                    ),
                    TourCtg(
                      icon: natureIcon,
                      ctgName: 'Nature',
                    ),
                    TourCtg(
                      icon: shoppingIcon,
                      ctgName: 'Shopping',
                    ),
                  ],
                ),
              ),
              SizedBox(height: wDefaultPadding),
              WTitle(title: ' Description'),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    10, wDefaultPadding, 10, wDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: WText(
                          text:
                              'Khobar is a city and governorate in the Eastern province of the Kingdom of Saudi Arabia, situated on the coast of the Arabian Gulf. With a population of 457,748 as of 2017, Khobar is part of the Triplet Cities area, or Dammam metropolitan area along with Dammam and Dhahran, forming the residential core of the region.'),
                    )
                  ],
                ),
              ),
              WTitle(title: ' Tours in Khobar'),
              SizedBox(height: wDefaultPadding),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(wDefaultPadding, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      TourCard(
                        id: 0,
                        images: [
                          'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2021/04/28/2594231-1615587732.jpg?itok=M06pOZPO'
                        ],
                        tourTitle: 'KFUPM Tour',
                        rating: '-4.9',
                        price: 7999,
                        dest: ['3'],
                        ratingCount: '999',
                      ),
                      SizedBox(width: wDefaultPadding),
                      TourCard(
                        id: 1,
                        images: [
                          'https://images.unsplash.com/photo-1612899326681-66508905b4ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80'
                        ],
                        tourTitle: 'The Amazing Tour',
                        rating: '4.6',
                        price: 699,
                        dest: ['3'],
                        ratingCount: '420',
                      ),
                      SizedBox(width: wDefaultPadding),
                    ],
                  ),
                ),
              ),
              SizedBox(height: wDefaultPadding),
              WTitle(title: ' Locations in Khobar'),
              SizedBox(height: wDefaultPadding),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(wDefaultPadding, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      LocationCard(
                      ),
                      SizedBox(width: wDefaultPadding),
                      LocationCard(
                      ),
                      SizedBox(width: wDefaultPadding),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
