import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';
import '../../data.dart';
import '../../models/Locations/Province.dart';
import '../../widgets/Cards/Destination/DestinationCardList.dart';

// import 'createPlanScreen.dart';

class PlannerScreen extends StatefulWidget {
  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  List<Province> _provinceList = provinceData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: size.height * 0.34,
                    padding: EdgeInsets.only(
                      // top: 50,
                    ),
                  ),
                  Container(
                    height: size.height * 0.25,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(0, 7), // Shadow position
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          wPrimaryColor,
                          wPurple,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    width: 300,
                    child: Text(
                      'Fun and Handy Way to Plan Your Trips',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        fontFamily: wFont,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: size.height * 0.18,
                          width: size.width * 0.75,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                wPrimaryColor,
                                wPurple,
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20,
                                offset: Offset(0, -5), // Shadow position
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          width: 200,
                          child: Text(
                            'Start Planing for adventurous Trips to your favorite places in Saudi! ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: wFont,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          child: Container(
                            height: 30,
                            width: 120,
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: const BoxDecoration(
                                // color: white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(white),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                      )
                                    )
                                  ),
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => CreatePlanScreen(),
                                //   ),
                                // );
                                },
                              clipBehavior: Clip.antiAlias,
                              child: Text(
                                'Create my Plan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'My Plans',
                      style: TextStyle(
                          fontFamily: wFont,
                          fontSize: 20,
                          fontWeight: wBoldWeight),
                    )),
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Text(
                        'You do not have any plans yet',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child:
                  suggested(),
              ),

                      ],
                  ),
              ),
          ),
    );
  }

  suggested() {
    return DefaultTabController(
            length: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child:
                  Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Places You Might Like',
                              style: TextStyle(
                                  fontFamily: wFont,
                                  fontSize: 20,
                                  fontWeight: wBoldWeight),
                            )),
                  // TabBar(
                  //   tabs: [
                  //     Container(
                  //         padding: EdgeInsets.only(bottom: 5),
                  //         child: Text(
                  //           'Places You Might Like',
                  //           style: TextStyle(
                  //               fontFamily: wFont,
                  //               fontSize: 20,
                  //               fontWeight: wBoldWeight),
                  //         )),
                  //   ],
                  //   padding: EdgeInsets.only(left: 10),
                  //   indicatorSize: TabBarIndicatorSize.label,
                  //   isScrollable: true,
                  //   labelColor: wPrimaryColor,
                  //   indicatorColor: wPrimaryColor,
                  //   indicatorWeight: 3,
                  //   unselectedLabelColor: wGrey,
                  //   automaticIndicatorColorAdjustment: false,
                  //   labelPadding: EdgeInsets.only(right: 10, left: 10),
                  // ),
                ),
                Container(
                  height: 280,
                  child: TabBarView(
                    children: [
                      Container(
                        child: DestinationCardList(destinationList: _provinceList),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CreatePlanScreen {
  // return Container();
}
