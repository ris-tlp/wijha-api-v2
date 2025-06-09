import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/screens/TourTab/guide/guideTourScreen.dart';
import 'package:wijha/screens/blogs/blogScreen.dart';
import 'package:wijha/screens/forum/forumScreen.dart';
import 'package:wijha/screens/home/homeScreen.dart';
import 'package:wijha/screens/signUpIn/signUpIn.dart';
import 'package:wijha/screens/tourTab/tourist/touristTourScreen.dart';
import 'package:wijha/screens/userProfile/profileScreen.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/roundImage.dart';
import 'package:wijha/widgets/appBar.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/models/Users/User.dart';

class HomeMain extends ConsumerStatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeMain> createState() => _HomeMain();
}

// 2. Extend [ConsumerState]
class _HomeMain extends ConsumerState<HomeMain> {
  late List pages;
  // the home page index in the bottomNav
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wijha',
      theme: ThemeData(
        scaffoldBackgroundColor: wBackgroundColor,
        primaryColor: wPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: wJetBlack),
      ),
      home: Builder(builder: (context) {
        double width = MediaQuery.of(context).size.width;
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: bottomNavBar(),
            body: Consumer(builder: (context, ref, _) {
              final _auth = ref.watch(userProvider.notifier);

              pages = [
                // bottomNav Screens
                // CreateCustomLocation(),
                HomeScreen(),
                // SignUpIn(),
                // ProfileScreen(),
                BlogScreen(),
                // PlannerScreen(),
                ForumScreen(),
                _auth.getUser() is Guide
                    ? GuideTourScreen()
                    : TouristTourScreen(),
              ];

              return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  WAppBar(),
                ],
                body: Stack(
                    children: pages
                        .asMap()
                        .map((i, page) => MapEntry(
                            i,
                            Offstage(
                                offstage: _currentIndex != i, child: page)))
                        .values
                        .toList()),
              );
            }),
            drawer: Consumer(builder: (context, ref, _) {
              final _auth = ref.watch(userProvider.notifier);
              return drawer(context, _auth, width);
            }),
          ),
        );
      }),
    );
  }

  Container drawer(context, AuthenticationProvider _auth, double width) {
    return Container(
      color: white,
      width: width * 0.7,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            height: 270,
            decoration: BoxDecoration(gradient: wGradient),
            child: Center(
              child: _auth.getUser().type != 'guest'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              // color: wGrey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                        user: _auth.getUser(),
                                      ),
                                    ));
                              },
                              child: RoundImage(
                                imagePath: _auth.getUser().profilePicture,
                                netImage: _auth.getUser().profilePicture.contains('http://') || _auth.getUser().profilePicture.contains('https://'),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            _auth.getUser().userName,
                            style: TextStyle(
                              fontFamily: wFont,
                              color: white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              wDefaultPadding, 12, wDefaultPadding, 0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text(
                                    "Travel Points : " +
                                        _auth.getUser().travelPoints.toString(),
                                    style: TextStyle(
                                      fontFamily: wFont,
                                      color: white,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  color: white,
                                  thickness: 1.2,
                                ),
                                Container(
                                  child: Text(
                                    "Level " + (_auth.getUser().getLevel()).toString(),
                                    style: TextStyle(
                                      fontFamily: wFont,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignUpIn()));
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: white,
                            fontWeight: wBoldWeight,
                            fontFamily: wFont,
                            fontSize: 28),
                      ),
                    ),
            ),
          ),
          // GestureDetector(
          //   onTap: () => Navigator.push(
          //       context,
          //       new MaterialPageRoute(
          //           builder: (context) => NotificationScreen(
          //                 notificationList: [
          //                   Fact(
          //                       content: "This is a sample fact notification",
          //                       location: Location(
          //                         name: "City name",
          //                         description: "description",
          //                         imageUrl: "imageUrl",
          //                         city: 'city',
          //                         province: 'province',
          //                       ),
          //                       expVal: 20),
          //                   Fact(
          //                       content:
          //                           "This is a sample fact notification that is really long! AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH",
          //                       location: Location(
          //                         name: "City name",
          //                         description: "description",
          //                         imageUrl: "imageUrl",
          //                         city: 'city',
          //                         province: 'province',
          //                       ),
          //                       expVal: 20),
          //                 ],
          //               ))),
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          //     child: Container(
          //       child: Text(
          //         "Notification Center",
          //         style: TextStyle(
          //           fontFamily: wFont,
          //           fontSize: 16,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          if (_auth.getUser().type != 'guest') // Don't show sign out to guests
            GestureDetector(
              onTap: () => {
                _auth.signOut(),
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => SignUpIn()))
              },
              // Navigator.push(context,
              // new MaterialPageRoute(builder: (context) => MapScreen())),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Container(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontFamily: wFont,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  SafeArea bottomNavBar() {
    List<SalomonBottomBarItem> navItems = navBarItems();
    return SafeArea(
      child: Container(
        color: white,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: navItems,
        ),
      ),
    );
  }

  List<SalomonBottomBarItem> navBarItems() {
    var items = [
      SalomonBottomBarItem(
        icon: SvgPicture.asset(
          homeIcon,
          color: navItemColor(0),
          height: navItemSize(0),
        ),
        title: Text("Home"),
        selectedColor: wPrimaryColor,
      ),
      SalomonBottomBarItem(
        icon: SvgPicture.asset(
          blogIcon,
          color: navItemColor(1),
          height: navItemSize(1),
        ),
        title: Text("Blogs"),
        selectedColor: wPrimaryColor,
      ),
      // SalomonBottomBarItem(
      //   icon: SvgPicture.asset(
      //     plannerIcon,
      //     color: navItemColor(3),
      //     height: navItemSize(3),
      //   ),
      //   title: Text("Trip Plan"),
      //   selectedColor: wPrimaryColor,
      // ),
      SalomonBottomBarItem(
        icon: SvgPicture.asset(
          forumIcon,
          color: navItemColor(2),
          height: navItemSize(2),
        ),
        title: Text("Forum"),
        selectedColor: wPrimaryColor,
      ),
      SalomonBottomBarItem(
        icon: SvgPicture.asset(
          mapIcon,
          color: navItemColor(3),
          height: navItemSize(3),
        ),
        selectedColor: wPrimaryColor,
        title: Text("Tour"),
      ),
    ];
    return items;
  }

// switch color when active
  Color navItemColor(int index) {
    return _currentIndex == index ? wPrimaryColor : wGrey;
  }

// change size when active
  double navItemSize(int index) {
    return _currentIndex == index ? 20 : 18;
  }
}
