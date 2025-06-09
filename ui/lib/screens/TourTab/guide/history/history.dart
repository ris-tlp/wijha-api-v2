import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/tourProvider.dart';
import 'package:wijha/screens/tourTab/guide/history/tourHistoryCard.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import '../../../../data.dart';
import '../../../../models/Tours/Tour.dart';
import '../../../../widgets/searchWidget.dart';

class History extends ConsumerStatefulWidget {
  const History({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<History> createState() => _History();
}

class _History extends ConsumerState<History> {
  bool loading = true;
  int counter = 0;
  String query = '';
  String? sortingValue = 'Date';
  List<String> sortingList = ['Date', 'Title', 'Rating'];
  List<Tour>? tours;
  List<Tour>? displayTours;
  Future<List<Tour>>? futureTours;

  @override
  void initState() {
    super.initState();
    // tours = guide.tourHistoryList;
    // Fetch Tours
    // futureTours = Tour.fetchInactiveTours("5", false);
    // futureTours!.then((data) => setState(() {
    //       tours = data;
    //     }));
  }

  getTours(_user) {
    futureTours = Tour.fetchHistoryTours(_user.userName);
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
      // tours = ref.watch(tourProvider.notifier).getEndedToursByGuide(_auth.getUser());
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

      // if (tours != null) {
      //   if (counter == 0) {
      //     displayTours = tours;
      //     counter = 1;
      //   }
      // }

      return loading
          ? Loading()
          : SafeArea(
              child: Scaffold(
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
                                  return TourHistoryCard(
                                    tour: tour,
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            "You haven't registered for any tours yet!",
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
      else if (value.toLowerCase() == 'participants')
        displayTours!.sort((a, b) => a.rating.compareTo(b.rating));
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
