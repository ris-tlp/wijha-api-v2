import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final String imagePath;
  final Size size;
  final netImage;

  const RoundImage({
    Key ? key,
    required this.imagePath,
    this.size = const Size.fromWidth(120),
    this.netImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: !netImage ? Image.asset(
        imagePath,
        width: size.width,
        height: size.width,
        fit: BoxFit.fitWidth,
      ) :
      Image.network(imagePath, width: size.width, height: size.height,),
    );
  }
}
