import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/widgets/constants.dart';

class PickCtgWidget extends StatefulWidget {
  final List<WCategory> categories;

  PickCtgWidget({
    required this.categories,
  });

  @override
  _PickCtgWidgetState createState() => _PickCtgWidgetState();
}

class _PickCtgWidgetState extends State<PickCtgWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: wDefaultPadding),
            child: WTitle(title: 'Categorize Your Tour'),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: <Widget>[
                for (var i = 0; i < categories.length; i++) ...[
                  FilterChipWidget(ctg: categories[i], tourCategories: this.widget.categories),
                ],
              ],
            ),
          ),
        ),
        Divider(
          color: wGrey,
          height: 10.0,
          thickness: 0.8,
        ),
      ],
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  final WCategory ctg;
  final List<WCategory> tourCategories;

  FilterChipWidget({Key? key, required this.ctg, required this.tourCategories}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();

  isSelected() {}
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isSelected() {
    bool isSelected = false;
    if (widget.tourCategories.contains(widget.ctg)) isSelected = true;
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
        widget.ctg.icon,
        color: iconColor(),
        height: 18,
      ),
      showCheckmark: true,
      label: Text(
        widget.ctg.title,
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
            widget.tourCategories.add(widget.ctg);
          } else {
            widget.tourCategories.remove(widget.ctg);
          }
          String added = '';
          for (var i = 0; i < widget.tourCategories.length; i++) {
            added += widget.tourCategories[i].title + ' ';
          }
          print(added);
        });
      },
      selectedColor: wPrimaryColor,
      checkmarkColor: white,
    );
  }
}
