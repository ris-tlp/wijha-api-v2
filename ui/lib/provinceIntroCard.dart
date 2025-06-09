import 'package:flutter/material.dart';
import 'package:wijha/data.dart';
import 'package:wijha/providers/provinceProvider.dart';
import 'package:wijha/screens/home/homeMain.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyRadioOption extends ConsumerStatefulWidget {
  final int value;
  final int? groupValue;
  final String text;
  final String img;
  final bool intro;

  final Function onChanged;

  const MyRadioOption({
    required this.value,
    required this.groupValue,
    required this.text,
    required this.img,
    required this.onChanged,
    this.intro = true,
  });

  @override
  _MyRadioOptionState createState() => _MyRadioOptionState();
}

class _MyRadioOptionState extends ConsumerState<MyRadioOption> {
  Widget _buildLabel() {
    final bool isSelected = widget.value == widget.groupValue;

    return Container(
      width: 25,
      height: 25,
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: isSelected ? wPrimaryColor : Colors.white,
      ),
      child: Center(
          child: Icon(
        Icons.check_circle_rounded,
        size: 18,
        color: white,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.25,
      width: width * 0.40,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: height * 0.19,
            width: width * 0.40,
            decoration: BoxDecoration(
              color: wMagenta,
              image: DecorationImage(
                image: AssetImage(widget.img),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          cardInfo(width, context),
          Container(
            height: height * 0.19 + 10,
            width: width * 0.40,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  splashColor: wPrimaryColor.withAlpha(80),
                  onTap: () => {
                        widget.onChanged(widget.value),
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: wMagenta,
                              title: Center(
                                child: Text(
                                  'Change The Province To:',
                                  style: TextStyle(
                                    color: white,
                                    fontFamily: wFont,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * .3,
                                      width: width * .5,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Positioned(
                                            top: 0,
                                            child: Container(
                                              height: height * .3,
                                              width: width * .5,
                                              decoration: BoxDecoration(
                                                color: wPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image(
                                                  // width: width,
                                                  image: AssetImage(
                                                      provinceData[widget.value]
                                                          .imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.3 - 40,
                                            child: ConstrainedBox(
                                              constraints: new BoxConstraints(
                                                minWidth: width * .3,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          15))),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5),
                                                        child: Text(
                                                          provinceData[
                                                                  widget.value]
                                                              .name,
                                                          style: TextStyle(
                                                            fontFamily: wFont,
                                                            color: wPurple,
                                                            fontWeight:
                                                                wBoldWeight,
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
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: white,
                                      fontFamily: wFont,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                      color: white,
                                      fontFamily: wFont,
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.onChanged(widget.value);
                                    ref
                                        .read(provinceProvider.notifier)
                                        .change(provinceData[widget.value]);
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => HomeMain()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        )
                      }),
            ),
          ),
        ],
      ),
    );
  }

  Positioned cardInfo(double width, context) {
    return Positioned(
      top: MediaQuery.of(context).size.longestSide * 0.19 - 30,
      child: Container(
        width: width * 0.35,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.25),
          ),
        ], color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 14, fontFamily: wFont, fontWeight: wBoldWeight),
          ),
        ),
      ),
    );
  }
}
