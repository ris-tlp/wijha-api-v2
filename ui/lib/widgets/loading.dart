import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: wBackgroundColor,
      child: Center(
        child: SpinKitChasingDots(
          color: wMagenta,
          size: 50.0
        )
      )
    );
  }
}