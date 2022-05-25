import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../DetailsPage/Components/DetailsPageBody.dart';

class SearchQuery extends StatefulWidget {
  final userid;
  SearchQuery({Key? key, @required this.userid}) : super(key: key);

  @override
  _SearchQueryState createState() => _SearchQueryState();
}

class _SearchQueryState extends State<SearchQuery> {
  List search_result = [];
  String query = "";

  Future getresponse() async {
    try {
      if (query == "") {
      } else {
        var response = await Dio().get(
            "http://api.themoviedb.org/3/search/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&language=en-US&page=1&include_adult=false&query=" +
                query);
        var data = response.data;

        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  late Timer _timer;
  @override
  void initState() {
    _timer = Timer(
      Duration(milliseconds: 1000),
      () async {
        try {
          await this.getresponse().then((value) => {
                if (mounted)
                  {
                    setState(() {
                      search_result = value["results"];
                    })
                  }
              });
        } catch (e) {}
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Container(
            alignment: Alignment.center,
            color: HexColor("#272727"),
            child: TextField(
              cursorColor: Colors.white,
              onChanged: (text) {
                setState(() {
                  query = text;
                  try {
                    getresponse().then((value) => {
                          if (value == null)
                            {}
                          else
                            {
                              if (mounted)
                                {
                                  setState(() {
                                    search_result = value["results"];
                                  })
                                }
                            }
                        });
                  } catch (e) {}
                });
              },
              style: TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: HexColor("#7220C9"),
                  ),
                  // suffixIconColor: HexColor("#7220C9"),
                  filled: true,
                  fillColor: HexColor("#272727"),
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Search for a movie or genre'),
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        body: getname());
  }

  Widget getname() {
    if (query.isEmpty || query == "")
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Grab a popcorn and start watching 🎥🍟😋",
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
    if (search_result.isEmpty)
      return Center(child: CircularProgressIndicator());

    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ListView.builder(
        itemCount: search_result.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPageBody(
                    moviename: search_result[index]["original_title"],
                  ),
                ),
              );
              // print("clicked");
            },
            child: Container(
              margin: EdgeInsets.all(2),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 130,
                        width: 100,
                        child: search_result[index]["poster_path"] == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/loading.png')))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: FadeInImage.assetNetwork(
                                  image: "https://image.tmdb.org/t/p/w500" +
                                      search_result[index]["poster_path"],
                                  placeholder: "assets/images/loading.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50.w,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextScroll(
                                    search_result[index]['original_title']
                                            .toString()
                                            .isEmpty
                                        ? "Unknown"
                                        : search_result[index]
                                            ['original_title'],
                                    velocity: Velocity(
                                        pixelsPerSecond: Offset(20, 0)),
                                    pauseBetween: Duration(milliseconds: 1000),
                                    mode: TextScrollMode.bouncing,
                                    style: TextStyle(
                                        color: HexColor("#DEDEDE"),
                                        fontSize: 20),
                                    textAlign: TextAlign.right,
                                    selectable: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              "🌟 " +
                                  search_result[index]['vote_average']
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.54,
                            margin: EdgeInsets.only(top: 20, left: 5),
                            child: Text(
                              search_result[index]['release_date'],
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
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
