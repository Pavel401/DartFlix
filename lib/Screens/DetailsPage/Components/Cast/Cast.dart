import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../Cast Details/CastDetails.dart';

class Cast extends StatefulWidget {
  final id;
  final userid;
  final username;
  Cast({Key? key, @required this.id, this.userid, this.username})
      : super(key: key);

  @override
  _CastState createState() => _CastState();
}

class _CastState extends State<Cast> {
  List cast = [];

  void getpopularresponse() async {
    var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
        widget.id.toString() +
        "/credits?api_key=ebe86eb4e04342d7598d4096a16d8d11&language=en-US");
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          cast = data["cast"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
  }

  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return Container(
        height: 50.0,
        margin: EdgeInsets.only(top: 10, left: 20),
        width: double.infinity,
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
                period: Duration(milliseconds: 2000),
                baseColor: (Colors.grey[700])!,
                direction: ShimmerDirection.ltr,
                highlightColor: (Colors.grey[500])!,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(60)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0, right: 10),
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 40,
                      color: Colors.grey,
                    ),
                  ],
                ));
          },
        ),
      );
    }
    return Container(
        height: 50.0,
        margin: EdgeInsets.only(top: 10, left: 20),
        width: double.infinity,
        child: ListView.builder(
            itemCount: cast.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                         var _type = FeedbackType.success;
                    Vibrate.feedback(_type);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Castdetails(
                                castname: cast[index]["name"],
                                profilepath: cast[index]["profile_path"],
                                castid: cast[index]['id'])));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 1.h, bottom: 1.h, left: 1.w, right: 1.w),
                    child: Tiles(cast, index),
                  ));
            }));
  }

  Widget Tiles(cast, index) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#7220C9"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 30,
          ),
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(cast[index]["profile_path"] == null
                ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR28i5jWF37DvM01csPLTUTxEvCUAiL1ho6qw&usqp=CAU"
                : "https://image.tmdb.org/t/p/w500" +
                    cast[index]["profile_path"]),
          ),
          title: Text(
            cast[index]["name"],
            style: TextStyle(
                fontFamily: 'fonts/Lato-Bold.ttf',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
