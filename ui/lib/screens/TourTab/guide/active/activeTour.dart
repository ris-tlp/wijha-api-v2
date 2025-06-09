import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/tourProvider.dart';
import 'package:wijha/screens/tourTab/guide/active/tourActiveCard.dart';
import 'package:wijha/screens/tourTab/guide/tracker/guideTracker.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';

import '../../../../widgets/searchWidget.dart';

class ActiveTours extends ConsumerStatefulWidget {
  const ActiveTours({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ActiveTours> createState() => _ActiveTours();
}

class _ActiveTours extends ConsumerState<ActiveTours> {
  List<Tour>? tours;
  bool loading = true;
  Future<List<Tour>>? futureTours;
  List<Tour>? displayTours;
  int counter =
      0; // counter is used to initiate the state of displayTours. Without counter, displayTours will constantly update not allowing sorting
  String query = '';
  List<String> sortingList = ['Date', 'Title', 'Requests'];
  String? sortingValue = 'Date';

  @override
  void initState() {
    super.initState();
  }

  getTours(_user) {
    futureTours = Tour.fetchInactiveTours(_user.userName, false);
    futureTours!.then((data) => setState(() {
          tours = data;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      final _user = _auth.getUser();

      if (tours != null) {
        // setState(() {
        //   if (counter == 0) {
        //     displayTours = tours;
        //     counter = 1;
        //   }
        //   loading = false;
        // });
        if (counter == 0) {
          displayTours = tours;
          counter = 1;
        }
        loading = false;
      } else {
        getTours(_user);
      }

      return loading
          ? Loading()
          : SafeArea(
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    bool done = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuideTrackerPage()));
                    if (done) {
                      setState(() {});
                    }
                  },
                  backgroundColor: wPrimaryColor,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 40,
                    color: white,
                  ),
                ),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          expandedHeight: 60,
                          centerTitle: true,
                          title: SvgPicture.asset(
                            wLogo,
                            color: white,
                            height: 25,
                          ),
                          backgroundColor: wPurple,
                          forceElevated: innerBoxIsScrolled,
                        ),
                      ),
                    ];
                  },
                  body: tours!.length > 0
                      ? Column(
                          children: [
                            buildSearch(),
                            Expanded(
                              child: ListView.builder(
                                itemCount: displayTours!.length,
                                itemBuilder: (context, index) {
                                  final tour = displayTours![index];
                                  return TourActiveCard(tour: tour);
                                },
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            "You don't have any active tours yet!",
                            style: TextStyle(
                              color: wJetBlack,
                              fontSize: 18,
                              fontFamily: wFont,
                              fontWeight: wBoldWeight,
                            ),
                          ),
                        ),
                ),
              ),
            );
    });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchTours,
        hintText: 'Search tours by title',
        sorted: true,
        dropDownList: sortingList,
        dropDownValue: sortingValue,
        sort: sortTours,
      );

  void searchTours(String query) {
    final tours = this.tours!.where((tour) {
      final titleLower = tour.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.displayTours = tours;
    });
  }

  void sortTours(String? value) {
    setState(() {
      sortingValue = value;
      if (value!.toLowerCase() == 'date')
        displayTours!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      else if (value.toLowerCase() == 'title')
        displayTours!.sort((a, b) => a.title.compareTo(b.title));
      else if (value == 'requests')
        displayTours!.sort((a, b) => a.registrationRequests.length
            .compareTo(b.registrationRequests.length));
    });
  }

  Widget buildLocation(int index, Tour tour) => Card(
        key: ValueKey(tour),
        margin: const EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
        child: ListTile(
          title: Text(
            tour.title,
            style: TextStyle(
              fontFamily: wFont,
              fontSize: 16,
              fontWeight: wBoldWeight,
              color: wMagenta,
            ),
          ),
          subtitle: Text(
            tour.description,
            style: TextStyle(
              fontFamily: wFont,
              fontSize: 12,
              color: wGrey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
}
