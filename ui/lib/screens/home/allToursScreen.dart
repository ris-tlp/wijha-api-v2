import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/widgets/Cards/Tours/tourCardList.dart';
import 'package:wijha/widgets/constants.dart';

import '../../models/Tours/Category.dart';
import '../../widgets/Tags/whiteCtg.dart';

class AllToursScreen extends StatefulWidget {
  final List<Tour> tours;
  final Province province;

  const AllToursScreen({required this.province, required this.tours, Key? key}) : super(key: key);

  @override
  State<AllToursScreen> createState() => _AllToursScreenState();
}

class _AllToursScreenState extends State<AllToursScreen> {
  late ImageProvider? image;

  // @override
  // void initState() {
  //   setState(() {
  //     image = (widget.province.imageNet ?
  //     NetworkImage(widget.province.imageUrl) as ImageProvider<Object>?
  //         :
  //     AssetImage(
  //       widget.province.imageUrl,
  //     ));
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: logoAppBar,
          backgroundColor: wBackgroundColor,
          body: TourCardList(toursList: widget.tours, scrollDirection: Axis.vertical, shrinkWrap: true,),
        )
    );
  }
  //
  // SliverOverlapAbsorber imgSliderHeader(BuildContext context, double height, bool innerBoxIsScrolled) {
  //   return SliverOverlapAbsorber(
  //     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
  //     sliver: SliverAppBar(
  //       centerTitle: true,
  //       title: SvgPicture.asset(
  //         wLogo,
  //         color: white,
  //         height: 25,
  //       ),
  //       backgroundColor: wPurple,
  //       pinned: true,
  //       flexibleSpace: FlexibleSpaceBar(
  //         background: Container(
  //           height: height * .4,
  //           child: Image(
  //               fit: BoxFit.cover,
  //               image: image!
  //           ),
  //         ),
  //       ),
  //       expandedHeight: height * 0.40,
  //       collapsedHeight: 60,
  //       forceElevated: innerBoxIsScrolled,
  //     ),
  //   );
  // }
  //
  // titleHeader(double width) {
  //   return Column(
  //     children: [
  //       Container(
  //         width: width,
  //         color: white,
  //         padding: EdgeInsets.symmetric(
  //             horizontal: wDefaultPadding, vertical: wDefaultPadding),
  //         child: Row(
  //           children: <Widget>[
  //             destinationWOrigin(width),
  //           ],
  //         ),
  //       ),
  //       ctgSlider(width, []),
  //     ],
  //   );
  // }
  //
  // destinationWOrigin(double width) {
  //   return Container(
  //     width: width - 100,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(right: 10),
  //           child: TourTitle(title: widget.province.name),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // Container ctgSlider(double width, List<WCategory> ctgList) {
  //   return Container(
  //     width: width,
  //     padding: EdgeInsets.symmetric(
  //       vertical: 10,
  //     ) +
  //         EdgeInsets.only(
  //           left: 10,
  //         ),
  //     decoration: BoxDecoration(
  //       gradient: wGradient,
  //     ),
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Row(children: [
  //         for (var i = 0; i < ctgList.length; i++) ...[
  //           WhiteCtg(ctg: ctgList[i]),
  //         ],
  //       ]),
  //     ),
  //   );
  // }
}
