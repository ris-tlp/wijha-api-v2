import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Users/Tourist.dart';
import 'package:wijha/screens/tourTab/tourist/registered/tourRegisteredCard.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';

import '../../../../providers/authProvider.dart';
import '../../../../providers/tourProvider.dart';
import '../../../../widgets/searchWidget.dart';

class RegisteredTours extends ConsumerStatefulWidget {
  const RegisteredTours({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RegisteredTours> createState() => _RegisteredTours();
}

class _RegisteredTours extends ConsumerState<RegisteredTours> {
  List<Tour>? tours;
  List<Tour>? displayTours;
  int counter = 0;
  String query = '';
  List<String> sortingList = ['Date', 'Title'];
  String? sortingValue = 'Date';

  Future<List<Tour>>? futureTours;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // tours = toursData.where((tour) => tour.registrationRequests.contains(tourist)).toList();
  }

  void fetchActiveTours(Tourist user) {
    futureTours = user.fetchTouristInactiveTours();
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
      // tours = ref.watch(tourProvider.notifier).getToursByTourist(_auth.getUser() as Tourist); // This is used for demo purposes. It may be changed when connected to the backend
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
          loading = false;
        }
      } else {
        fetchActiveTours(_user);
      }

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
                                  return TourRegisteredCard(
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
