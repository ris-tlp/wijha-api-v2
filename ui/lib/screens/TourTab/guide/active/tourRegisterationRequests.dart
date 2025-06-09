import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/screens/userProfile/userProfileWidgets/roundImage.dart';

import '../../../../data.dart';
import '../../../../widgets/constants.dart';
import '../../../../widgets/searchWidget.dart';

class TourRegistrationRequests extends StatefulWidget {
  final Tour tour;

  const TourRegistrationRequests({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourRegistrationRequests> createState() => _TourRegistrationRequestsState();
}

class _TourRegistrationRequestsState extends State<TourRegistrationRequests> {
  List<Request>? requests;
  String query = '';

  @override
  void initState() {
    super.initState();
    requests = widget.tour.registrationRequests;
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
              requests!.length > 0 ?
              Expanded(
                child: ListView.builder(
                  itemCount: requests == null ? 0 : requests!.length,
                  itemBuilder: (context, index) {
                    final request = requests![index];
                    return buildRequest(index, request);
                  },
                ),
              )
              :
              Container(
                height: 120,
                alignment: Alignment.center,
                child: Text(
                  'No registration requests',
                  style: TextStyle(
                    fontFamily: wFont,
                    fontSize: 22,
                    fontWeight: wBoldWeight,
                    color: wPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    onChanged: searchRequests,
    hintText: 'Search requests by user',
  );

  void searchRequests(String query) {
    final requests = widget.tour.registrationRequests.where((request) {
      final nameLower = request.user.userName.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.requests = requests;
    });
  }

  Widget buildRequest(int index, Request request) => Card(
    key: ValueKey(request),
    margin: const EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
    child: ListTile(
      leading: RoundImage(imagePath: request.user.profilePicture, netImage: request.user.netImage, size: Size(50, 50),),
      title: Text(
        request.user.userName,
        style: TextStyle(
          fontFamily: wFont,
          fontSize: 16,
          fontWeight: wBoldWeight,
          color: wMagenta,
        ),
      ),
      subtitle:
      request.status == 0 ?
      Text(
          'Pending',
          style: TextStyle(
          fontFamily: wFont,
          fontSize: 12,
          color: wGrey,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
      :
      request.status == 1 ?
      Text(
        'Accepted',
        style: TextStyle(
          fontFamily: wFont,
          fontSize: 12,
          color: Colors.green,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
      :
      Text(
        'Rejected',
        style: TextStyle(
          fontFamily: wFont,
          fontSize: 12,
          color: Colors.red,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
              ),
              onPressed: () {
                request.approve();
                refresh();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                request.deny();
                refresh();
              },
            ),
          ],
        ),
      ),
    ),
  );

  refresh() {
    setState(() { });
  }
}
