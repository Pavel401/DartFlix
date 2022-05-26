// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Screens/DetailsPage/Components/DetailsPageBody.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Recommendations extends StatefulWidget {
  final id;
  final movie_name;

  Recommendations({
    Key? key,
    @required this.id,
    this.movie_name,
  }) : super(key: key);

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  List popularlist = [];
  List recommend = [];
  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Container(
                height: 140,
                width: 140,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              AntDesign.plussquare,
                              color: Colors.red,
                              size: 30,
                            ),
                            const Text(
                              "Add TO WATCHLIST",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: Colors.white),
                            ),
                          ],
                        ))),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            child: const Text(
                          "CLOSE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )))
                  ],
                ))),
          );
        });
  }

  void contentbasedrecommendations() async {
    try {
      var response = await Dio().get(
          "https://enage22.herokuapp.com/send/" + widget.movie_name.toString());
      var data = response.data;
      if (mounted) {
        setState(() {
          if (mounted) {
            popularlist = data;
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void apibased() async {
    try {
      var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
          widget.id.toString() +
          "/recommendations?api_key=ebe86eb4e04342d7598d4096a16d8d11&language=en-US&page=1");

      var data = response.data;
      if (mounted) {
        setState(() {
          recommend = data['results'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    contentbasedrecommendations();
    apibased();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 2.h,
                left: 2.w,
                right: 2.w,
              ),
              child: Text("Recommendations Based on ML Model",
                  style: TextStyle(
                      color: HexColor("#7220C9"),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
            ),
            getallpopularmoviecard(),
            getallpopularmoviecards(),
          ],
        ),
      ),
    );
  }

  Widget getlottie() {
    return Center(
      child: Container(
        height: 30.h,
        width: 80.w,
        child: Lottie.asset("assets/images/analysing.json"),
      ),
    );
  }

  Widget getallpopularmoviecard() {
    if (popularlist.isEmpty) {
      return getlottie();
    } else {
      return Container(
          color: Colors.black,
          margin: const EdgeInsets.only(top: 10),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: popularlist.isNotEmpty ? popularlist.length : 0,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPageBody(
                                            moviename: popularlist[index]
                                                ["title"],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 160,
                              width: double.infinity,
                              child: popularlist[index]["poster_path"] == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: const Image(
                                          fit: BoxFit.cover,
                                          image: const AssetImage(
                                              'assets/images/loading.png')))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: FadeInImage.assetNetwork(
                                        image:
                                            "https://image.tmdb.org/t/p/w500" +
                                                popularlist[index]
                                                    ["poster_path"],
                                        placeholder:
                                            "assets/images/loading.png",
                                        fit: BoxFit.cover,
                                      )),
                            )),
                        Positioned(
                          top: 3,
                          right: 0,
                          child: InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ));
              }));
    }
  }

  Widget getallpopularmoviecards() {
    if (popularlist.isEmpty) {
      return Container(
          margin: const EdgeInsets.only(top: 10),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: 12,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: const Duration(milliseconds: 2000),
                  baseColor: HexColor("#8970A4"),
                  direction: ShimmerDirection.ltr,
                  highlightColor: HexColor("#463567"),
                  child: Container(
                    height: 160,
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: (Colors.purple[200])!,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    } else {
      return Container(
        color: Colors.black,
        margin: const EdgeInsets.only(top: 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: (130.0 / 190.0),
          ),
          shrinkWrap: true,
          itemCount: recommend.isNotEmpty ? recommend.length : 0,
          controller: ScrollController(keepScrollOffset: false),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black),
              child: Stack(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPageBody(
                                      moviename: recommend[index]["title"],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 160,
                        width: double.infinity,
                        child: recommend[index]["poster_path"] == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/loading.png')))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FadeInImage.assetNetwork(
                                  image: "https://image.tmdb.org/t/p/w500" +
                                      recommend[index]["poster_path"],
                                  placeholder: "assets/images/loading.png",
                                  fit: BoxFit.cover,
                                )),
                      )),
                  const Positioned(
                      top: 3,
                      right: 0,
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      )),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
