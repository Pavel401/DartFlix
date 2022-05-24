import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String relase_data;
  final String rating;
  final String url;
  const CustomCard(
      {Key? key,
      required this.title,
      required this.relase_data,
      required this.rating,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.solid,
          width: 0.5,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22.0),
      ),
      height: 70.h,
      width: 90.w,
      child: Card(
        color: Colors.grey.withOpacity(0.60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        elevation: 15,
        child: Stack(
          children: [
            Container(
              width: 90.w,
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.0),
                  topRight: Radius.circular(22.0),
                ),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage.assetNetwork(
                  image: url.toString(),
                  placeholder: "images/loading.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 56.h,
              left: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 2.w,
                ),
                child: Text(
                  title.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 60.h,
              left: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 2.w,
                ),
                child: Row(
                  children: [
                    Text(
                      "Release Date : " + relase_data.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 64.h,
              left: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 2.w,
                ),
                child: Row(
                  children: [
                    Text(
                      "⭐ " + rating.toString(),
                      style: TextStyle(
                        color: HexColor("#DEDEDE"),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
