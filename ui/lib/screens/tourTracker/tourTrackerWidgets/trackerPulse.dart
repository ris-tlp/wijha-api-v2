import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

class PulsatingCircleIconButton extends StatefulWidget {
  const PulsatingCircleIconButton({
    Key ?key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final Icon icon;
  final Text text;

  @override
  _PulsatingCircleIconButtonState createState() => _PulsatingCircleIconButtonState();
}

class _PulsatingCircleIconButtonState extends State<PulsatingCircleIconButton> with SingleTickerProviderStateMixin {
 late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Ink(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: wPrimaryColor.withOpacity(0.1),
              shape: BoxShape.rectangle,
              boxShadow: [
                for (int i = 1; i <= 2; i++)
                  BoxShadow(
                    color: wPrimaryColor.withOpacity(_animationController.value / 2),
                    blurRadius: 0,
                    // spreadRadius: _animation.value * 0,
                  )
              ],
            ),
            child: Align(
              // alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                widget.icon,
                widget.text,
              ],
            ),
            ),
          );
        },
      ),
    );
  }
}