import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Screens/Home/components/HomeCarousle.dart';
import 'package:indiflix/Screens/Swipe%20Cards/components/BottomBar.dart';
import 'package:indiflix/Screens/Swipe%20Cards/components/CustomCard.dart';
import 'package:sizer/sizer.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../main.dart';
import '../CustomListFromUserHistory/Model/History.dart';
import '../DetailsPage/Components/DetailsPageBody.dart';
import 'Model/data.dart';
import 'components/CustomAlert.dart';

class SwipableCards extends StatefulWidget {
  const SwipableCards({Key? key}) : super(key: key);

  @override
  State<SwipableCards> createState() => _SwipableCardsState();
}

class _SwipableCardsState extends State<SwipableCards> {
  List val = [];

  Future getrandom() async {
    var response = await Dio().get("https://enage22.herokuapp.com/getswipe");
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          val = data;
        });

        load();
        create_cards();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getrandom();

    //print(names.toList());
  }

  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  static List<String> names = [];
  List<String> releaseyear = [];
  List<String> images = [];
  List<String> ratings = [];

  void load() {
    for (var i = 0; i < val.length; i++) {
      names.add(val[i]["original_title"].toString());
      releaseyear.add(val[i]["release_date"].toString());
      images.add(val[i]["poster_path"].toString());
      ratings.add(val[i]["vote_average"].toString());
    }
  }
List<String> movies = [];
  void storedata(String name, String url, String id) async {
    User user = User(
      name,
      url,
      id,
    );
    String userdata = jsonEncode(user);
    print("userdata is" + userdata.toString());
    // print(name.toUpperCase());
    movies.add(userdata.toString());
    recommemdedmovies = preferences.getStringList('saverecommendation') ?? [];
    for (int i = 0; i < recommemdedmovies.length; i++) {
      if (recommemdedmovies[i] == userdata) {
        return;
      }
    }
    recommemdedmovies.add(userdata.toString());
    recommemdedmovies.toSet().toList();
    preferences.setStringList("saverecommendation", recommemdedmovies);
  }
  void create_cards() {
    for (int i = 0; i < names.length; i++) {
      _swipeItems.add(
        SwipeItem(
          content: Content(
              title: names[i],
              rating: ratings[i],
              year: releaseyear[i],
              url: images[i]),
          likeAction: () {
             storedata(
                          names[i].toString(),
                          "https://image.tmdb.org/t/p/original" +
                                                  images[i].toString(),
                          ratings[i].toString());
            actions(context, names[i], 'Liked');
          },
          nopeAction: () {
            actions(context, names[i], 'Rejected');
          },
        ),
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#121212"),
        appBar: AppBar(
          backgroundColor: HexColor("#272727"),
          title: Text(
            "Sugest a Movie",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
        body: val.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 73.h,
                          width: 90.w,
                          child: SwipeCards(
                            matchEngine: _matchEngine!,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 70.h,
                                width: 90.w,
                                alignment: Alignment.bottomLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 0.5,
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(22.0),
                                          topRight: Radius.circular(22.0),
                                        ),
                                        color: Colors.black,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(22.0),
                                          topRight: Radius.circular(22.0),
                                        ),
                                        child: FadeInImage.assetNetwork(
                                          image:
                                              "https://image.tmdb.org/t/p/original" +
                                                  images[index].toString(),
                                          placeholder:
                                              "assets/images/loading.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    SizedBox(
                                      width: 80.w,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextScroll(
                                              names[index] == "NULL"
                                                  ? "N/A"
                                                  : names[index].toString(),
                                              velocity: Velocity(
                                                  pixelsPerSecond:
                                                      Offset(20, 0)),
                                              pauseBetween:
                                                  Duration(milliseconds: 1000),
                                              mode: TextScrollMode.bouncing,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: HexColor("#DEDEDE"),
                                                  fontSize: 20),
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
                                    SizedBox(
                                      width: 80.w,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextScroll(
                                              releaseyear[index] == "NULL"
                                                  ? "Release Date" + "N/A"
                                                  : "Release Date : " +
                                                      releaseyear[index]
                                                          .toString(),
                                              velocity: Velocity(
                                                  pixelsPerSecond:
                                                      Offset(20, 0)),
                                              pauseBetween:
                                                  Duration(milliseconds: 1000),
                                              mode: TextScrollMode.bouncing,
                                              style: TextStyle(
                                                  color: HexColor("#DEDEDE"),
                                                  fontSize: 15),
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
                                    SizedBox(
                                      width: 80.w,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextScroll(
                                              ratings[index] == "NULL"
                                                  ? "Ratings : " + "⭐ " + "N/A"
                                                  : "Ratings : " +
                                                      "⭐ " +
                                                      ratings[index].toString(),
                                              velocity: Velocity(
                                                  pixelsPerSecond:
                                                      Offset(20, 0)),
                                              pauseBetween:
                                                  Duration(milliseconds: 1000),
                                              mode: TextScrollMode.bouncing,
                                              style: TextStyle(
                                                  color: HexColor("#DEDEDE"),
                                                  fontSize: 15),
                                              textAlign: TextAlign.right,
                                              selectable: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80.w,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPageBody(
                                                    moviename: names[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onStackFinished: () {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('The List is over')));
                            },
                          ),
                        ),
                        Container(
                          height: 7.h,
                          // color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {

                                    _matchEngine!.currentItem!.nope();
                                         var _type = FeedbackType.warning;
                    Vibrate.feedback(_type);
                                  },
                                  child: buttonWidget(
                                      Icons.close, HexColor("#7220C9"))),
                              InkWell(
                                onTap: () {
                                       var _type = FeedbackType.success;
                    Vibrate.feedback(_type);
                                  _matchEngine!.currentItem!.like();
                                },
                                child: buttonWidget(
                                    Icons.favorite_outline_outlined,
                                    HexColor("#7220C9")),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}

