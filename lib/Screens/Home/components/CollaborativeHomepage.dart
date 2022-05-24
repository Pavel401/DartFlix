import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../Onboarding Page/Genere selection/Components/GenreChips.dart';
import '../../../main.dart';
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
  String primary_url =
      "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=";
  String secondary_url =
      "https://api.themoviedb.org/3/movie/popular?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_original_language=";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Persistent Genre" + persistedGenres.toList().toString());
    print(FilterChipDisplay.filters.toList());
    print("Persistent languge" + persistedLanguages.toList().toString());

    // int count=FilterChipDisplay
  }

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
  Map<String, String> language_codes = {
    'English': "en",
    'Hindi': "hi",
    'Bengali': "bn",
    'Telugu': "te",
    'Tamil': "ta",
    'Kannada': "kn",
    'Marathi': "mr",
    'Gujarati': "gu",
    'Punjabi': "pa",
    'Oriya': "or",
  };
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
          persistedGenres.isNotEmpty
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: persistedGenres.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getlatest(
                        persistedGenres[index].toString(),
                        primary_url + check(persistedGenres[index]).toString(),
                        "");
                  })
              : Container(),
          persistedLanguages.isNotEmpty
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: persistedLanguages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getlatest(
                        persistedLanguages[index].toString(),
                        secondary_url +
                            fetchlanguage_code(persistedLanguages[index])
                                .toString(),
                        "");
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  String fetchlanguage_code(String language) {
    String language_code = "";
    bool stop = false; //bool for checking
    for (int i = 0; i < persistedLanguages.length; i++) {
      if (stop) {
        break;
      }
      {
        if (language_codes.keys.elementAt(i) == language.toString()) {
          language_code = language_codes.values.elementAt(i).toString();
          stop = true;
        }
      }
    }
    return language_code;
  }

  String check(String m) {
    bool stop = false; //bool for checking
    String val = "";
    int n = 0;
    //for appending the data
    for (int i = 0; i < genres_ids.length; i++) {
      if (stop) {
        break;
      }
      if (genres_ids.keys.elementAt(i) == m) {
        val = genres_ids.values.elementAt(i).toString();
        stop = true;
      }
    }

    return val;
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
