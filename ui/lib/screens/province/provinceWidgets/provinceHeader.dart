import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

@Deprecated('This widget should not be used')
class ProvinceHeader extends StatefulWidget {
  final String provinceImage;
  final String province;

  const ProvinceHeader({
    Key? key,
    required this.provinceImage,
    required this.province,
  }) : super(key: key);

  @override
  State<ProvinceHeader> createState() => _ProvinceHeaderState();
}

class _ProvinceHeaderState extends State<ProvinceHeader> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      // It will cover 25% of our total height
      height: height * 0.60,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              image: DecorationImage(
                image: AssetImage(this.widget.provinceImage),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: wGrey,
                  offset: Offset(.3, 1.5),
                ),
                BoxShadow(
                  color: wGrey,
                  offset: Offset(-.3, 1.5),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              gradient: wPictureTint,
            ),
          ),
          Positioned(
            bottom: 46,
            left: 0,
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: wDefaultPadding,
                ),
                child: Stack(
                  children: [
                    Text(
                      this.widget.province,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: wBoldWeight,
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: wFont,
                      ),
                    ),
                    Text(
                      this.widget.province,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: wBoldWeight,
                        fontSize: 32,
                        fontFamily: wFont,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = .25
                          ..color = wJetBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom:16,
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       left: wDefaultPadding,
          //     ),
          //     child: Row(
          //       children: [
          //         ProvinceTag(
          //           ctgName: 'Adventure',
          //           icon: '',
          //         ),
          //         ProvinceTag(
          //           ctgName: 'Nature',
          //           icon: '',
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
