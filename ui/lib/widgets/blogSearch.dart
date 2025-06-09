import 'package:flutter/material.dart';
import 'package:wijha/widgets/blogSearchScreen.dart';
import 'package:wijha/widgets/constants.dart';

class BlogSearchBar extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool sorted;
  final List<String>? dropDownList;
  final String? dropDownValue;
  final ValueChanged<String?>? sort;

  const BlogSearchBar({
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
  _BlogSearchBar createState() => _BlogSearchBar();
}

class _BlogSearchBar extends State<BlogSearchBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => BlogSearchScreen()),
        );
      },
      child: Container(
        height: 42,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(Icons.search, color: wGrey),
            SizedBox(width: 10),
            Text(
              this.widget.hintText,
              style: TextStyle(
                color: wGrey,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogSearch extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const BlogSearch({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _BlogSearch createState() => _BlogSearch();
}

class _BlogSearch extends State<BlogSearch> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        autofocus: true,
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
