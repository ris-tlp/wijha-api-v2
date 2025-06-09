import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool sorted;
  final List<String>? dropDownList;
  final String? dropDownValue;
  final ValueChanged<String?>? sort;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
    this.sorted = false,
    this.dropDownList,
    this.dropDownValue,
    this.sort,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: widget.sorted ? const EdgeInsets.only(left: 8) :const EdgeInsets.symmetric(horizontal: 8),
      child: widget.sorted ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * .6,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: style.color),
                suffixIcon: widget.text.isNotEmpty
                    ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
                    : null,
                hintText: widget.hintText,
                hintStyle: style,
                border: InputBorder.none,
              ),
              style: style,
              onChanged: widget.onChanged,
            ),
          ),
          Container(
            width: width * .2,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              color: wMagenta,
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: wMagenta,
              iconSize: 20,
              iconEnabledColor: white,
              style: TextStyle(color: white, fontFamily: wFont, fontWeight: wBoldWeight),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              value: widget.dropDownValue,
              items: widget.dropDownList?.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: widget.sort
            ),
          ),
        ],
      ) :
      TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}