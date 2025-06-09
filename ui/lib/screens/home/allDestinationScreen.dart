import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Locations/DestinationInterface.dart';
import 'package:wijha/widgets/Cards/Destination/DestinationCardList.dart';
import 'package:wijha/widgets/constants.dart';

class AllDestinationScreen extends StatefulWidget {
  final List<Destination> destinationList;

  const AllDestinationScreen({required this.destinationList, Key? key}) : super(key: key);

  @override
  State<AllDestinationScreen> createState() => _AllDestinationScreenState();
}

class _AllDestinationScreenState extends State<AllDestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: logoAppBar,
        body: DestinationCardList(destinationList: widget.destinationList, detailed: false, scrollDirection: Axis.vertical,),
      )
    );
  }
}
