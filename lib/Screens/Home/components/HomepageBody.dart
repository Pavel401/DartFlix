import 'package:flutter/material.dart';
import 'package:indiflix/Screens/Home/components/HomeCarousle.dart';
import 'package:indiflix/Screens/MoreMoviesPage.dart/GetLists.dart';
import 'package:shimmer/shimmer.dart';

import '../../ExtendedComponents/MovieListFetch.dart';
import '../../MoreMoviesPage.dart/MoreMoviesPage.dart';

class HomepageBody extends StatefulWidget {
  const HomepageBody({Key? key}) : super(key: key);

  @override
  State<HomepageBody> createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  String s = "";

  List data = [
    {
      "name": "",
      "url": "",
    },
    {
      "name": "",
      "url": "",
    },
    {
      "name": "Top Rated",
      "url":
          "https://api.themoviedb.org/3/movie/top_rated?api_key=ebe86eb4e04342d7598d4096a16d8d11&language=en-US&page=2",
    },
    {
      "name": "",
      "url":
          "https://api.themoviedb.org/3/movie/popular?api_key=ebe86eb4e04342d7598d4096a16d8d11&language=en-US&page=1",
    },
    {
      "name": "Top Movies of 2022",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&primary_release_date.gte=2020-01-01&primary_release_year=2022",
    },
    {
      "name": "Hindi Movies",
      "url":
          "https://api.themoviedb.org/3/movie/popular?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_original_language=hi",
    },
    {
      "name": "Action Movies",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=18",
    },
    {
      "name": "Horror",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=27"
    },
    {
      "name": "kids",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=16"
    },
    {
      "name": "Thriller",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=9648"
    },
    {
      "name": "Romance",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=10749"
    },
    {
      "name": "Family",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=10751"
    },
    {
      "name": "Crime",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=80"
    },
    {
      "name": "Mystry",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=9648",
    },
    

  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: getlist());
  }

  Widget getlist() {
    return ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) return gethead();
          if (index == 1) return HomeCarousle();
          if (index == 3) return Container();
          

          return getlatest(data[index]["name"], data[index]['url'], "");
        });
  }

  Widget gethead() {
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              const SizedBox(
                  height: 43,
                  width: 43,
                  child: Image(
                    color: Colors.pink,
                    fit: BoxFit.cover,
                    image: AssetImage("images/logo3.png"),
                  )),
              Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: (Colors.grey[100])!,
                  direction: ShimmerDirection.ltr,
                  highlightColor: (Colors.grey[800])!,
                  child: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: const Text("Dart Flix",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold)))),
            ]),
            InkWell(
                highlightColor: Colors.grey,
                hoverColor: Colors.white,
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28.0,
                )),
          ],
        ));
  }

  Widget getlatest(name, url, recentname) {
    return Container(
        child: Column(
      children: [
        TopShimmer(name, url),
        Latest(
          url: url,
          // id: widget.id,
          // username: widget.username,
          recentname: recentname,
        ),
      ],
    ));
  }

  Widget TopShimmer(name, url) {
    return Container(
        margin: EdgeInsets.only(top: 15, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 5,
                  margin: EdgeInsets.only(right: 8, left: 2),
                  decoration: BoxDecoration(color: Colors.blue[300]),
                ),
                Shimmer.fromColors(
                    period: Duration(milliseconds: 2000),
                    baseColor: (Colors.grey[100])!,
                    direction: ShimmerDirection.ltr,
                    highlightColor: (Colors.grey[800])!,
                    child: Container(
                        width: 250,
                        child: Text(name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)))),
              ],
            ),
            name == "Cuz you searched for " + s
                ? Container()
                : Container(
                    child: InkWell(
                    highlightColor: Colors.grey,
                    hoverColor: Colors.white,
                    onTap: () {},
                    child: InkWell(
                      highlightColor: Colors.grey,
                      hoverColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MoreMoviesPage(
                                      url: url,
                                      originalmoviename: name,
                                    ))));
                      },
                      child: Text("See More",
                          style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ))
          ],
        ));
  }
}
