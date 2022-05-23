import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../MoreMoviesPage.dart/MoreMoviesPage.dart';
import '../../Search/Components/Searchqueryshow.dart';
import '../ExtendedComponents/FetchHorizontalMovieList.dart';
import 'HomeCarousle.dart';

class CollaborativeHomePage extends StatefulWidget {
  const CollaborativeHomePage({Key? key}) : super(key: key);

  @override
  State<CollaborativeHomePage> createState() => _CollaborativeHomePageState();
}

class _CollaborativeHomePageState extends State<CollaborativeHomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          gethead(),
          HomeCarousle(),
          getlatest(
              "Top Rated",
              "https://api.themoviedb.org/3/movie/top_rated?api_key=ebe86eb4e04342d7598d4096a16d8d11&language=en-US&page=2",
              ""),
          getlatest(
              "Top Movies of 2022",
              "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&primary_release_date.gte=2020-01-01&primary_release_year=2022",
              ""),

              SizedBox(
                height: 4.h,
              ),
          getlatest(
              "Top Rated",
              "https://api.themoviedb.org/3/movie/top_rated?api_key=ebe86eb4e04342d7598d4096a16d8d11&language=en-US&page=2",
              ""),
        ],
      ),
    );
  }

  Widget getlatest(name, url, recentname) {
    return Container(
        child: Column(
      children: [
        TopShimmer(name, url),
        FetchHorizontalMovieList(
          url: url,
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
                  decoration: BoxDecoration(color: HexColor("#7220C9")),
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
            Container(
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
                          )),
                    ),
                  );
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

  Widget gethead() {
    //appbar and searchbar
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchQuery()));
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28.0,
                )),
          ],
        ));
  }
}