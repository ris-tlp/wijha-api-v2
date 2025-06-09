import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wijha/widgets/constants.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        child: Stack(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.5,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/tours/jeddahAlbalad.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                bottom: 75,
                left: 20,
                child: Text(
                  'Jeddah Albalad',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                left: 20,
                child: Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 35,
                        decoration: const BoxDecoration(
                            color: wPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Historical',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 35,
                        decoration: const BoxDecoration(
                            color: wPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Fun',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            child: Container(
              height: size.height * 0.5,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  'Al-Balad was founded in the 7th century and historically served as the centre of Jeddah. Al-Balad\'s defensive walls were torn down in the 1940s. In the 1970s and 1980s, when Jeddah began to become wealthier due to the oil boom, many Jeddawis moved north, away from Al-Balad, as it reminded them of less prosperous times',
                  style: TextStyle(
                    color: wJetBlack,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: (size.width / 2) - 60,
            child: Container(
              height: 40,
              width: 120,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                  color: wJetBlack,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: SvgPicture.asset(
                      'assets/icons/map.svg',
                      color: Colors.white,
                      height: 17,
                    ),
                  ),
                  const Text(
                    'View on map',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
