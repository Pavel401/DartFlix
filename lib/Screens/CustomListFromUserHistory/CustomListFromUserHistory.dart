import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Screens/DetailsPage/Components/DetailsPageBody.dart';
import 'package:indiflix/main.dart';
import 'package:shimmer/shimmer.dart';

import '../DetailsPage/ErrorPage/Error.dart';

List<String> movielist = [];
List moviedatas = [];

class CustomListFromUserHistory extends StatefulWidget {
  final url;
  final id;
  final username;
  final recentname;
  List moviesfromhistory = [];
  CustomListFromUserHistory(List<String> remembermovies,
      {Key? key,
      @required this.url,
      this.id,
      this.username,
      this.recentname,
      required this.moviesfromhistory})
      : super(key: key);

  @override
  _CustomListFromUserHistoryState createState() =>
      _CustomListFromUserHistoryState();
}

class _CustomListFromUserHistoryState extends State<CustomListFromUserHistory> {
  List val = [];
  List watchlist = [];
  bool add = false;
  Future fetchMovieData() async {
    if (widget.id == null) return;
    final String url = "https://enage22.herokuapp.com/watch/" + widget.id;
    try {
      var response = await Dio().get(url);
      return response.data['post'];
    } catch (e) {
      print(e);
    }
  }

  Future getresponse() async {
    var response = await Dio().get(widget.url);
    var data = response.data;
    try {
      if (widget.recentname != "") {
        if (mounted) {
          setState(
            () {
              val = data;
            },
          );
        }
      } else {
        if (mounted) {
          setState(() {
            val = data["results"];
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.moviesfromhistory.isEmpty) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 168.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: const Duration(milliseconds: 2000),
                  baseColor: HexColor("#8970A4"),
                  direction: ShimmerDirection.ltr,
                  highlightColor: HexColor("#463567"),
                  child: Container(
                    width: 118,
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: (Colors.purple[200])!,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: 168.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.moviesfromhistory.length != null ? val.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPageBody(
                      moviename: moviedatas[index]["original_title"],
                    ),
                  ),
                );
              },
              child: Container(
                width: 118,
                margin: EdgeInsets.all(6.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //   color: Colors.white,
                        ),
                        height: 200,
                        width: 120,
                        child: moviedatas.isEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: const Image(
                                  image:
                                      AssetImage("assets/images/loading.png"),
                                  fit: BoxFit.cover,
                                ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FadeInImage.assetNetwork(
                                  image: "https://image.tmdb.org/t/p/w780"+
                                      moviedatas[index]["poster_path"]
                                          .toString(),
                                  placeholder: "assets/images/loading.png",
                                  fit: BoxFit.cover,
                                ))),
                    Positioned(
                      bottom: 3,
                      right: 0,
                      child: GestureDetector(
                          onTap: () {
                            //add the ontap method after clicking the three dot menu
                          },
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
