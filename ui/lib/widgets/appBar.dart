import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      floating: true,
      snap: true,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: SvgPicture.asset(
        'assets/logos/English.svg',
        color: wPrimaryColor,
        height: 25,
      ),
      leading: IconButton(
        icon: Container(
          height: 25,
          width: 25,
          child: SvgPicture.asset(
            'assets/icons/hamburgerMenu.svg',
          ),
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: <Widget>[
        Container(
          height: 25,
          width: 25,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
