import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/widgets/constants.dart';

class landingPage extends StatefulWidget {
  @override
  State<landingPage> createState() => _landingPage();
}

class _landingPage extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/RiyadhMain.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: size.height * 0.3,
          width: size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(wEngLogo),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SvgPicture.asset(
                  wEngLogo,
                  color: wPrimaryColor,
                  fit: BoxFit.cover,
                  height: 30,
                ),
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: wDefaultPadding),
                  child: Text(
                    'Start exploring Saudi Arabia within a few clicks.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: wJetBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: wFont,
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 65),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      decoration: const BoxDecoration(
                          color: wPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: wFont,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 65),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      decoration: const BoxDecoration(
                          color: wPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: wFont,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(wDefaultPadding),
                child: Text(
                  'Continue as a guest',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontFamily: wFont,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
