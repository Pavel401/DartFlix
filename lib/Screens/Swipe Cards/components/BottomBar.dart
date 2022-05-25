import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      // color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonWidget(Icons.close, Colors.red),
                    buttonWidget(Icons.play_circle, Colors.red),

          buttonWidget(Icons.favorite_outline_outlined, Colors.pink),
        ],
      ),
    );
  }
}

Widget buttonWidget(IconData icon, Color color) {
  return Container(
    height: 10.h,
    width: 10.w,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: color)),
    child: Icon(
      icon,
      color: color,
      size: 30,
    ),
  );
}
