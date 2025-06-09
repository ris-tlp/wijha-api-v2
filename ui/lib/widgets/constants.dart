import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/screens/tour/tourWidgets/tourCtg.dart';

const Color wPrimaryColor = Color(0xFFD91B5C);
const Color wPurple = Color(0xFF93278E);
const Color wMagenta = Color(0xFFBD2070);
const Color wJetBlack = Color(0xFF3C3C3C);
const Color wBackgroundColor = Color(0xFFF4F4F4);
const Color wGrey = Color(0xFFA1A1A1);
const Color white = Color(0xFFFFFFFF);

const String wFont = 'Lato';

const FontWeight wLightWeight = FontWeight.w300;
const FontWeight wRegularWeight = FontWeight.w400;
const FontWeight wBoldWeight = FontWeight.w700;
const FontWeight wBlackWeight = FontWeight.w900;

const LinearGradient wGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    wPrimaryColor,
    wPurple,
  ],
);

const LinearGradient wGradient2 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    wPrimaryColor,
    wPurple,
  ],
);

const LinearGradient wPictureTint = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.transparent,
    Colors.transparent,
    wJetBlack,
  ],
);

const LinearGradient wCardButtonGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    wMagenta,
    wPrimaryColor,
    wPurple,
  ],
);

const double wDefaultPadding = 20.0;

class WTitle extends StatelessWidget {
  final String title;

  const WTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        fontFamily: wFont,
        fontWeight: wBoldWeight,
        fontSize: 20,
        color: wPrimaryColor,
      ),
    );
  }
}

final AppBar logoAppBar = AppBar(
  elevation: 0,
  centerTitle: true,
  title: SvgPicture.asset(
    wLogo,
    color: white,
    height: 25,
  ),
  backgroundColor: wPurple,
);

class WText extends StatelessWidget {
  final String text;
  const WText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontWeight: wRegularWeight,
        fontSize: 16,
        color: wJetBlack,
      ),
    );
  }
}

class TourTitle extends StatelessWidget {
  final String title;

  const TourTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        fontFamily: wFont,
        fontWeight: wBoldWeight,
        fontSize: 24,
        color: wJetBlack,
      ),
    );
  }
}

class TourCardTitle extends StatelessWidget {
  final String title;

  const TourCardTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        fontFamily: wFont,
        fontWeight: wBoldWeight,
        fontSize: 18,
        color: wJetBlack,
      ),
    );
  }
}

// bottomNav icons
const String homeIcon = 'assets/icons/home.svg';
const String blogIcon = 'assets/icons/blog.svg';
const String forumIcon = 'assets/icons/forum.svg';
const String mapIcon = 'assets/icons/map.svg';
const String plannerIcon = 'assets/icons/trip.svg';

// appbar icons
const String profileIcon = 'assets/icons/profile.svg';
const String menuIcon = 'assets/icons/hamburgerMenu.svg';
const String wEngLogo = 'assets/logos/English.svg';
const String wLogo = 'assets/logos/sus_logo.svg';

const String searchIcon = 'assets/icons/search.svg';
const String locationIcon = 'assets/icons/location.svg';

const String priceIcon = 'assets/icons/money.svg';
const String starIcon = 'assets/icons/star.svg';

const String saMapIcon = 'assets/icons/saudiMap.svg';
const String categoryIcon = 'assets/icons/category.svg';
const String writeIcon = 'assets/icons/write.svg';

// categories icons
const String adventureIcon = 'assets/icons/jeep.svg';
const String beachIcon = 'assets/icons/beach.svg';
const String cruiseIcon = 'assets/icons/cruise.svg';
const String historicalIcon = 'assets/icons/castle.svg';
const String museumIcon = 'assets/icons/museum.svg';
const String natureIcon = 'assets/icons/trees.svg';
const String shoppingIcon = 'assets/icons/shopping.svg';

const String adventureStr = 'Adventure';
const String beachStr = 'Beaches';
const String cruiseStr = 'Cruises';
const String historicalStr = 'Historical';
const String museumStr = 'Museum';
const String natureStr = 'Nature';
const String shoppingStr = 'Shopping';

const TourCtg adventureCtg =
    TourCtg(icon: adventureIcon, ctgName: adventureStr);
const TourCtg beachCtg = TourCtg(icon: beachIcon, ctgName: beachStr);
const TourCtg cruiseCtg = TourCtg(icon: cruiseIcon, ctgName: beachStr);
const TourCtg historicalCtg =
    TourCtg(icon: historicalIcon, ctgName: historicalStr);
const TourCtg museumCtg = TourCtg(icon: menuIcon, ctgName: museumStr);
const TourCtg natureCtg = TourCtg(icon: natureIcon, ctgName: natureStr);
const TourCtg shoppingCtg = TourCtg(icon: searchIcon, ctgName: shoppingStr);
