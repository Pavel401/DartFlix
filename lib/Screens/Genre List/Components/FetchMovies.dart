import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Screens/MoreMoviesPage.dart/Widgets/MovieCard.dart';
import 'package:shimmer/shimmer.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class fetchGenreData extends StatefulWidget {
  final genre;
  final page;
  final id;
  fetchGenreData({Key? key, this.genre, required this.page, required this.id})
      : super(key: key);

  @override
  _fetchGenreDataState createState() => _fetchGenreDataState();
}

class _fetchGenreDataState extends State<fetchGenreData> {
  String url =
      "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=";
  List popularlist = [];
//HashMap of genres data
  Map<String, int> genres_ids = {
    'Adventure': 12,
    'Fantasy': 14,
    'Animation': 16,
    'Drama': 18,
    'Horror': 27,
    'Action': 28,
    'Comedy': 35,
    'History': 36,
    'Western': 37,
    'Thriller': 53,
    'Crime': 80,
    'Documentary': 99,
    'Science Fiction': 878,
    'Mystery': 9648,
    'Music': 10402,
    'Romance': 10749,
    'Family': 10751,
    'War': 10752,
    'TV Movie': 10770,
  };
  List genres = [];
  void getpopularresponse() async {
    var response = await Dio().get(
      url + this.widget.id.toString() + "&page=" + this.widget.page.toString(),
    );

    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          popularlist = data["results"];
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

  @override
  Widget build(BuildContext context) {
    return getallpopularmoviecard();
  }

  Widget getallpopularmoviecard() {
    if (popularlist.isEmpty)
      return Container(
        margin: EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 18,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: HexColor("#8970A4"),
              direction: ShimmerDirection.ltr,
              highlightColor: HexColor("#463567"),
              child: Container(
                height: 170,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: (Colors.purple[200])!,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            );
          },
        ),
      );
    else
      return Container(
          margin: EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 18,
              itemBuilder: (BuildContext context, int index) {
                genres = popularlist[index]["genre_ids"];
                return MovieCard(
                  title:
                      popularlist[index]["original_title"].toString() == "null"
                          ? "NULL"
                          : popularlist[index]["original_title"].toString(),
                  rating:
                      popularlist[index]["vote_average"].toString() == "null"
                          ? "NULL"
                          : popularlist[index]["vote_average"].toString(),
                  //director: "Pavel",
                  released_year:
                      popularlist[index]["release_date"].toString() == "null"
                          ? "NULL"
                          : popularlist[index]["release_date"].toString(),
                  url: popularlist[index]["poster_path"].toString() == "null"
                      ? "NULL"
                      : "https://image.tmdb.org/t/p/w780" +
                          popularlist[index]["poster_path"].toString(),
                  type: check(),
                );
              }));
  }

//Zindagi mai isse complex function nahi likha hu joki first compile mai kam kar jaye :)
  List check() {
    bool stop = false; //bool for checking
    String val = ""; //for appending the data
    List pass_genres = []; //this list will be passed
    int i = 0; //the initialization of the loop
    int n = genres.length; //the maximmum times the loop will run

    while (i < n) {
      for (var key in genres_ids.keys) {
        //if the value of the key is equal to the value of the genres list which is a hash map declared above in the code contains
        //key and values pairs
        //i am checking the json genre ids with the hashmaps keys and values
        if (genres_ids[key] == genres[i]) {
          val = key;
          stop = true;
          break;
        }
      }
      if (stop == true) {
        pass_genres.add(val);
        stop = false;
      }
      i++; //incrementing
    }
    return pass_genres;
  }
}
