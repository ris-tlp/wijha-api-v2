import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Locations/Province.dart';
import 'package:wijha/providers/provinceProvider.dart';
import 'package:wijha/screens/home/homeMain.dart';
import 'package:wijha/widgets/Cards/Province/provinceIntroCard.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';

class IntroScreen extends ConsumerStatefulWidget {
  @override
  _IntroScreen createState() => _IntroScreen();
}

class _IntroScreen extends ConsumerState<IntroScreen> {
  bool loading = true;
  int? _groupValue = 0;
  List<Province>? provinces;
  Future<List<Province>>? futureProvinces;
  final introKey = GlobalKey<IntroductionScreenState>();

  ValueChanged<int?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  void initState() {
    futureProvinces = Province.fetchAllProvinces();
    futureProvinces!.then((data) => setState(() {
          provinces = data;
          loading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return loading
        ? Loading()
        : SafeArea(
            child: IntroductionScreen(
              key: introKey,
              globalBackgroundColor: wPurple,

              rawPages: [
                Container(
                  padding: const EdgeInsets.only(top: wDefaultPadding),
                  decoration: BoxDecoration(gradient: wGradient),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: wDefaultPadding),
                        child: Text(
                          'Welcome to',
                          style: TextStyle(
                            color: white,
                            fontFamily: wFont,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        wEngLogo,
                        height: 40,
                        color: white,
                      ),
                      SizedBox(height: wDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: SvgPicture.asset(
                          'assets/icons/service-tourist.svg',
                          height: width * 0.45,
                          color: white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: wDefaultPadding),
                        child: Text(
                          'A place to find guided tours around the kingdom',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: white,
                            fontFamily: wFont,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: wDefaultPadding),
                  decoration: BoxDecoration(gradient: wGradient2),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: wDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              saMapIcon,
                              height: 40,
                              color: white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Choose a Province To Explore',
                              style: TextStyle(
                                color: white,
                                fontFamily: wFont,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.77,
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            spacing: 5,
                            children: [
                              for (var i = 0; i < provinces!.length; i++) ...[
                                MyRadioOption<int>(
                                  value: i,
                                  groupValue: _groupValue,
                                  onChanged: _valueChangedHandler(),
                                  text: provinces![i].name,
                                  img: provinces![i].imageUrl,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: wDefaultPadding),
                  decoration: BoxDecoration(gradient: wGradient),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: wDefaultPadding),
                          child: Text(
                            'Start Exploring',
                            style: TextStyle(
                              color: white,
                              fontFamily: wFont,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          height: height * .4,
                          width: width * .8,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: 0,
                                child: Container(
                                  height: height * 0.4,
                                  width: width * .8,
                                  decoration: BoxDecoration(
                                    color: wPrimaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image(
                                      // width: width,
                                      image: NetworkImage(
                                          provinces![_groupValue!].imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: height * 0.4 - 40,
                                child: ConstrainedBox(
                                  constraints: new BoxConstraints(
                                    minWidth: width * .5,
                                  ),
                                  child: Container(
                                    height: 40,
                                    width: width * .5,
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(15))),
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              provinces![_groupValue!].name,
                                              style: TextStyle(
                                                fontFamily: wFont,
                                                color: wPurple,
                                                fontWeight: wBoldWeight,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
              onDone: () => {
                ref
                    .read(provinceProvider.notifier)
                    .change(provinces![_groupValue!]),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomeMain()),
                )
              },
              //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
              showSkipButton: false,
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: true,
              //rtl: true, // Display as right-to-left
              back: const Icon(Icons.arrow_back, color: white),
              next: const Icon(Icons.arrow_forward, color: white),
              done: const Text('Confirm',
                  style: TextStyle(fontWeight: FontWeight.w600, color: white)),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsPadding: kIsWeb
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: white,
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          );
  }
}
