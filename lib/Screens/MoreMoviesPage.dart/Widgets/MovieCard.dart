import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../DetailsPage/Components/DetailsPageBody.dart';

class MovieCard extends StatefulWidget {
  final String title;
  final String rating;

  final released_year;
  final String url;
  final List type;

  const MovieCard(
      {Key? key,
      required this.title,
      required this.rating,
      required this.released_year,
      required this.url,
      required this.type})
      : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPageBody(
                      moviename: this.widget.title,
                    )));
      },
      child: Container(
        color: Colors.transparent,
        height: 22.h,
        width: 90.w,
        //color: Colors.black,
        child: Card(
          color: HexColor("#1E1E1E"),
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 15.h,
                  width: 30.w,
                  child: this.widget.url.toString() == "NULL"
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage("images/loading.png"),
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            image: this.widget.url.toString(),
                            placeholder: "images/loading.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 50.w,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextScroll(
                            this.widget.title.toString() == "NULL"
                                ? "N/A"
                                : this.widget.title.toString(),
                            velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
                            pauseBetween: Duration(milliseconds: 1000),
                            mode: TextScrollMode.bouncing,
                            style: TextStyle(
                                color: HexColor("#DEDEDE"), fontSize: 20),
                            textAlign: TextAlign.right,
                            selectable: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    this.widget.rating.toLowerCase() == "NULL"
                        ? "N/A"
                        : "⭐ " + this.widget.rating.toLowerCase(),
                    style: TextStyle(
                      color: HexColor("#DEDEDE"),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    this.widget.released_year.toString() == "null"
                        ? "N/A"
                        : "Released : " + this.widget.released_year.toString(),
                    style: TextStyle(
                      color: HexColor("#DEDEDE"),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                 this.widget.type.isEmpty?Container(
                   
                 ) :getgenres(this.widget.type),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getgenres(List data) {
    if (data.isEmpty)
      return Container(
        height: 8.h,
        width: 40.w,
        child: const Center(child: CircularProgressIndicator()),
      );

    return Container(
        height: 8.h,
        margin: const EdgeInsets.only(top: 8),
        width: 60.w,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Chip(
                  //   labelPadding: EdgeInsets.all(2.0),

                  label: Text(data[index],
                      style: const TextStyle(
                          // fontFamily: 'fonts/Lato-Bold.ttf',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none)),
                  backgroundColor: HexColor("#7220C9"),
                  elevation: 2.0,
                ),
              );
            }));
  }
}
