import 'package:flutter/material.dart';
class CircleHolder extends StatelessWidget {
  final Widget child;
  final double height;
  final Color color;
  final double width;
  //final void Function() onPressed;

  const CircleHolder(
      {Key? key,
      required this.child,
      required this.height,
      required this.width,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}