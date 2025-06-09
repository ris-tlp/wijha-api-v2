import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/tourProvider.dart';
import 'package:wijha/screens/tourTracker/tourTrackerWidgets/trackerPulse.dart';
import 'package:wijha/screens/tourTracker/trackerScreen.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;
import '../../../models/Tours/Tour.dart';
import '../../../models/Users/Tourist.dart';
import '../../../data.dart';
import '../../home/homeScreen.dart';
import 'cryptography.dart';

class QRScannerTourist extends StatefulWidget {
  @override
  State<QRScannerTourist> createState() => _QRScannerTouristState();
}

class _QRScannerTouristState extends State<QRScannerTourist> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      final _tour = ref.watch(tourProvider.notifier);

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: SvgPicture.asset(
              wLogo,
              color: white,
              height: 25,
            ),
            backgroundColor: wPurple,
          ),
          body: Stack(
            children: <Widget>[
              Center(child: _buildQrView(context)),
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  height: 120,
                  decoration: BoxDecoration(
                      color: wPurple,
                      border: Border(top: BorderSide(color: white, width: 5)),
                      boxShadow: [
                        BoxShadow(
                            color: wGrey,
                            offset: Offset(0, -1),
                            blurRadius: 5,
                            spreadRadius: .25)
                      ]),
                  child: tourInit(result, _auth.getUser()),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: wPurple,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      Fluttertoast.showToast(msg: 'No permission');
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  tourInit(Barcode? result, Tourist user) {
    if (result != null) {
      String? tourID = result.code!;
      print(tourID);

      user.markTouristAttendance(tourID);

      Fluttertoast.showToast(msg: 'Your attendance was taken successfully!');

      // Mark the attendance of a tourist within the tour

    }
    // if (result != null)
    // {
    //   bool success = false;
    //   String? tourID = base64Decode(result.code!).first.toString();
    //   print(tourID);
    //   print(tours.map((tour) => tour.id).toList());
    //   Tour tour = tours.firstWhere((element) => element.id == int.parse(tourID));
    //   print(user.activeTour?.guide);
    //   if (user.hasActiveTour())
    //     Fluttertoast.showToast(
    //         msg: "You're already attending this tour!");
    //   else {
    //     if (user.activeTour == null && user.inTour == false) {
    //       print(tour.registrationRequests.length);
    //       for (User registered
    //           in tour.registrationRequests.map((e) => e.user)) {
    //         print(user.userName);
    //         if (registered == user) {
    //           tourist.setActiveTour(tour);
    //           tour.markAttendance(user);
    //           user.addPoints(Tour.travelPoints * .3 ~/ 1);
    //           success = true;
    //           Fluttertoast.showToast(
    //               msg: 'Your attendance was taken successfully!');

    //           /// Once scanned, refresh HomeScreen
    //           /// Refresh is taken care of, I need the tour to be updated in tourist now
    //         }
    //       }
    //     }
    //     if (!success)
    //       Fluttertoast.showToast(msg: 'You are not registered in this tour!');
    //   }
    // }
    return Center(
        child: Text('Scan tour QR code to sign your attendance',
            style: TextStyle(
              color: white,
              fontWeight: wBoldWeight,
              fontSize: 18,
              fontFamily: wFont,
            )));
  }
}
