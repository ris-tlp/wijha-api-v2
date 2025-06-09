import 'dart:convert';
import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'cryptography.dart';

class QRGenerationGuide extends StatefulWidget {
  final Tour tour;

  QRGenerationGuide({
    required this.tour,
  });

  @override
  State<QRGenerationGuide> createState() => _QRGenerationGuideState();
}

class _QRGenerationGuideState extends State<QRGenerationGuide> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    String qrCode = widget.tour.id.toString();
    // String encryptedQrCode = Cryptography.encryptAES(qrCode);
    // String encryptedQrCode = qrCode;

    // print(encryptedQrCode);
    // inspect(
    //     Cryptography.decryptAES(Cryptography.encryptAES(qrCode).toString()));

    return SafeArea(
      child: Scaffold(
        backgroundColor: wBackgroundColor,
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
          children: [
            Center(
              child: QrImage(
                data: qrCode, //this would represent tour id
                size: 350,
                foregroundColor: wJetBlack,
                // embeddedImage: AssetImage("assets/logos/wijhaLogo.png"),
                // embeddedImageStyle: QrEmbeddedImageStyle(size: Size(60, 60))
              ),
            ),
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
                child: Center(
                  child: Text(
                    'Scan to take participant attendance',
                    style: TextStyle(
                      color: white,
                      fontWeight: wBoldWeight,
                      fontSize: 22,
                      fontFamily: wFont,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
