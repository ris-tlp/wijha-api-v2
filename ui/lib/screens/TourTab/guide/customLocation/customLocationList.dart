import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Locations/CustomLocation.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/screens/tour/customLocations.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../widgets/searchWidget.dart';

class CustomLocationList extends StatefulWidget {
  @override
  State<CustomLocationList> createState() => _CustomLocationListState();
}

class _CustomLocationListState extends State<CustomLocationList> {
  bool loading = true;
  Future<List<CustomLocation>?>? futureCustomLocations;
  List<CustomLocation>? customLocations;
  List<CustomLocation>? displayLocations;
  List<String> sortingList = ['Name'];
  String? sortingValue = 'Name';
  String query = '';
  int counter = 0; // 0 for initialization

  fetchCustomLocationsByGuide(User user) {
    futureCustomLocations = CustomLocation.fetchCustomLocationsByGuide(user);
    futureCustomLocations!.then((data) => setState(() {
          customLocations = data;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      User user = _auth.getUser();

      if (customLocations != null) {
        if (counter == 0) {
          displayLocations = customLocations;
          counter = 1;
        }
        loading = false;
      } else {
        fetchCustomLocationsByGuide(user);
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
                  body: Column(
                    children: [
                      buildSearch(),
                      customLocations!.length > 0
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: displayLocations?.length,
                                itemBuilder: (context, index) {
                                  final location = displayLocations![index];
                                  return buildLocation(index, location, user);
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                "You don't have any custom locations yet!",
                                style: TextStyle(
                                  color: wJetBlack,
                                  fontSize: 18,
                                  fontFamily: wFont,
                                  fontWeight: wBoldWeight,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CustomLocationPage())),
                  backgroundColor: wPrimaryColor,
                ),
              ),
            );
    });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchLocations,
        hintText: 'Search locations by title',
        sorted: false,
        dropDownList: sortingList,
        dropDownValue: sortingValue,
        sort: sortLocations,
      );

  void searchLocations(String query) {
    final customLocations = this.customLocations?.toList().where((location) {
      final titleLower = location.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      print(displayLocations);
      this.query = query;
      this.displayLocations = customLocations;
    });
  }

  void sortLocations(String? value) {
    setState(() {
      sortingValue = value;
      if (value!.toLowerCase() == 'name')
        displayLocations!.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  Widget buildLocation(int index, CustomLocation location, User user) => Card(
      key: ValueKey(location),
      margin: const EdgeInsets.fromLTRB(10, 2.5, 10, 0),
      child: Container(
        height: 105,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(25), left: Radius.circular(2.5)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: Container(
                height: 105,
                width: 150,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: wGrey, blurRadius: 1.25)],
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(15), left: Radius.circular(2.5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(15), left: Radius.circular(2.5)),
                  child: Image(
                    image: NetworkImage(location.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
                left: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Text(
                        location.name,
                        style: TextStyle(
                          fontFamily: wFont,
                          fontSize: 18,
                          fontWeight: wBoldWeight,
                          color: wMagenta,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: .5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Text(
                        location.locationFact != null
                            ? location.locationFact
                            : 'No fact given',
                        style: TextStyle(
                          fontFamily: wFont,
                          fontSize: 14,
                          color: wGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
            Positioned(
              right: 2,
              bottom: .05,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: wPrimaryColor,
                    ),
                    onPressed: () => remove(index, user),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
      // child: ListTile(
      //   leading: Padding(
      //     padding: const EdgeInsets.all(4.0),
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(20),
      //       child: Image.network(location.image
      //           // image: Image.network(location.image),
      //           ),
      //     ),
      //   ),
      //   title: Text(
      //     location.name,
      //     style: TextStyle(
      //       fontFamily: wFont,
      //       fontSize: 16,
      //       fontWeight: wBoldWeight,
      //       color: wMagenta,
      //     ),
      //   ),
      //   subtitle: Text(
      //     location.description,
      //     style: TextStyle(
      //       fontFamily: wFont,
      //       fontSize: 12,
      //       color: wGrey,
      //     ),
      //     maxLines: 1,
      //     overflow: TextOverflow.ellipsis,
      //   ),
      //   trailing: IconButton(
      //     icon: Icon(
      //       Icons.delete,
      //       color: wPrimaryColor,
      //     ),
      //     onPressed: () => remove(index),
      //   ),
      // ),
      );

  void remove(int index, User user) {
    // Remove CustomLocation from database
    customLocations?[index].deleteCustomLocation(user);
    setState(() {
      customLocations?.removeAt(index);
    });
  }
}
