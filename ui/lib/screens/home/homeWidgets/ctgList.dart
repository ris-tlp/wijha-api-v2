import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/widgets/Buttons/ctgBtn.dart';
import 'package:wijha/widgets/constants.dart';

class CategoriesList extends StatelessWidget {
  final List<WCategory> categoriesList;

  CategoriesList({required this.categoriesList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            wDefaultPadding, wDefaultPadding, 0, wDefaultPadding),
        child: Row(children: [
          for (var i = 0; i < categoriesList.length; i++) ...[
            CtgBtn(category: categoriesList[i]),
            SizedBox(width: 15),
          ],
        ]),
      ),
    );
  }
}
