import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Tours/tourInclude.dart';
import 'package:wijha/widgets/constants.dart';

class PickIncludedWidget extends StatefulWidget {
  final List<TourInclude> included;

  PickIncludedWidget({
    required this.included,
  });

  @override
  _PickIncludedWidgetState createState() => _PickIncludedWidgetState();
}

class _PickIncludedWidgetState extends State<PickIncludedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: wDefaultPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: WTitle(
              title: 'Whats Included: ',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: wDefaultPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: <Widget>[
                  for (var i = 0; i < include.length; i++) ...[
                    FilterChipWidget(incl: include[i], tourIncl: widget.included),
                  ],
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.blueGrey,
          height: 10.0,
        ),
      ],
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  final TourInclude incl;
  final List<TourInclude> tourIncl;

  FilterChipWidget({Key? key, required this.incl, required this.tourIncl}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isSelected() {
    bool isSelected = false;
    if (widget.tourIncl.contains(widget.incl)) isSelected = true;
    return isSelected;
  }

  Color labelColor() {
    return _isSelected() == false ? wPurple : white;
  }

  Color iconColor() {
    return _isSelected() == false ? wPurple : wPrimaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      avatar: SvgPicture.asset(
        widget.incl.icon,
        color: iconColor(),
        height: 20,
      ),
      showCheckmark: true,
      label: Text(
        widget.incl.item,
      ),
      labelStyle: TextStyle(
          color: labelColor(),
          fontFamily: wFont,
          fontSize: 16.0,
          fontWeight: wBoldWeight),
      selected: _isSelected(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          isSelected = _isSelected();
          if (isSelected == false) {
            widget.tourIncl.add(widget.incl);
          } else {
            widget.tourIncl.remove(widget.incl);
          }
          String added = '';
          for (var i = 0; i < widget.tourIncl.length; i++) {
            added += widget.tourIncl[i].item + ' ';
          }
          print(added);
        });
      },
      selectedColor: wPrimaryColor,
      checkmarkColor: white,
    );
  }
}
