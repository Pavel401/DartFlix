import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Navigation/Navigation.dart';
import 'package:indiflix/Screens/DetailsPage/ErrorPage/Error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import '../../../main.dart';
import '../../CustomListFromUserHistory/Model/History.dart';
import 'About/About.dart';
import 'Cast/Cast.dart';
import 'Recommendations/Recommendations.dart';
import 'Reviews/Revies.dart';

class DetailsPageBody extends StatefulWidget {
  final moviename;

  DetailsPageBody({
    Key? key,
    @required this.moviename,
  }) : super(key: key);

  @override
  _DetailsPageBodyState createState() => _DetailsPageBodyState();
}

class _DetailsPageBodyState extends State<DetailsPageBody> {
  List moviedetails = [];

  launchurl() async {
    String url = "https://www.youtube.com/watch?v=" +
        moviedetails[1]["results"][0]["key"];
    if (await canLaunch(url) != null) {
      launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 25,
            alignment: Alignment.center,
            child: const Text(
              "Trailer not found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          action: SnackBarAction(
            label: 'Cancel',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    }
  }
launchurl2() async {
    String url = "https://www.youtube.com/results?search_query=" +
      moviedetails[0]['original_title'];
    if (await canLaunch(url) != null) {
      launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 25,
            alignment: Alignment.center,
            child: const Text(
              "Trailer not found",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          action: SnackBarAction(
            label: 'Cancel',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    }
  }
  void getpopularresponse() async {
    if (widget.moviename == null || widget.moviename == "") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ErrorPage()));
    }
    try {
      var response = await Dio().get(
          "https://enage22.herokuapp.com//getmovie/" +
              widget.moviename.toString());
      var data = response.data;
      if (mounted) {
        //if the widget is mounted in the tree then only set the state
        setState(() {
          moviedetails = data;
        });
      }
    } catch (e) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ErrorPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      getpopularresponse();
    } catch (e) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ErrorPage()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
Navigator.pop(context);
      remembermovies = preferences.getStringList('savedmoviehistory') ?? [];

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: DefaultTabController(
          length: 4,
          child: moviedetails.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.black,
                        expandedHeight: 380,
                        pinned: true,
                        bottom: TabBar(
                          isScrollable: true,
                          indicatorWeight: 3,
                          indicator: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: HexColor("#7220C9"), width: 3.0),
                            ),
                          ),
                          unselectedLabelColor: Colors.white,
                          tabs: [
                            Tab(
                              child: Container(
                                child: const Text("About",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: const Text("Cast",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: const Text("Recommends",
                                    style: const TextStyle(fontSize: 18)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: const Text("Reviews",
                                    style: const TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            moviedetails[0]['backdrop_path'] == null
                                ? Container(
                                    width: double.infinity,
                                    height: 230,
                                    child: const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "assets/images/loading.png",
                                        )))
                                : ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ],
                                      ).createShader(Rect.fromLTRB(
                                          0, 30, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: FadeInImage.assetNetwork(
                                      image:
                                          "https://image.tmdb.org/t/p/original" +
                                              moviedetails[0]['backdrop_path'],
                                      height: 230,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: 'assets/images/loading.png',
                                    ),
                                  ),
                            Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      widget.moviename,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: HexColor("#7220C9"),
                                      ),
                                    )),
                                    Container(
                                        child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text(
                                            moviedetails[0]['vote_average']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                   InkWell(
                                        onTap: () {
                                           moviedetails[1]["results"].toString().contains("key")?
                                          launchurl():launchurl2();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.all(5),
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.blueGrey),
                                            child: Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4, left: 5),
                                                    child: const Icon(
                                                        Icons.play_circle,
                                                        size: 22,
                                                        color: Colors.white)),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4,
                                                          left: 12,
                                                          top: 2),
                                                  child: const Text(
                                                    "Watch",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ))),
                                  ],
                                )),
                          ],
                        ))),
                        actions: [
                          GestureDetector(
                              onTap: () {
                                print("Three dot clicked");
                              },
                              child: const Icon(Icons.more_vert)),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      About(
                          production_companies: moviedetails[0]
                              ["production_companies"],
                          overview: moviedetails[0]['overview'],
                          moviename: moviedetails[0]['original_title'],
                          id: moviedetails[0]['id']),
                      Cast(
                        id: moviedetails[0]['id'],
                      ),
                      Recommendations(
                          id: moviedetails[0]['id'],
                          movie_name: widget.moviename),
                      Reviews(
                        id: moviedetails[0]['id'],
                        moviename: widget.moviename,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
