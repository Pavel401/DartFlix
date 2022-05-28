import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GreenSnackbar extends StatelessWidget {
  String title = "";
  String message = "";

  GreenSnackbar({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(16),
        height: 15.h,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 48,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      //fontWeight:FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 5,
top: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.error,
            size: 30,
            color: Colors.white,
          ),
        ),
      
      ),
    ]);
  }
}
