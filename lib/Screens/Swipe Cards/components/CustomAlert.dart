import 'package:flutter/material.dart';
import 'package:indiflix/Screens/Swipe%20Cards/components/BottomBar.dart';

actions(BuildContext context, String name, type) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
          Duration(seconds: 1),
          () {
            Navigator.of(context).pop(true);
          },
        );

        return AlertDialog(
          content: buttonWidget(
              type == 'Liked'
                  ? Icons.favorite
                  : type == 'Disliked'
                      ? Icons.close
                      : Icons.close,
              type == 'Liked'
                  ? Colors.pink
                  : type == 'Disliked'
                      ? Colors.red
                      : Colors.blue),
          title: Text(
            'You ${type} ${name} Movie. Your recommendation will be sent to the ML model.',
            style: TextStyle(
                color: type == 'Liked'
                    ? Colors.pink
                    : type == 'Rejected'
                        ? Colors.red
                        : Colors.blue),
          ),
        );
      });
}
