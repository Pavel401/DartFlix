import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Onboarding%20Page/Language%20Selection/components/LanguageChips.dart';
import 'package:indiflix/Screens/CustomListFromUserHistory/CustomListFromUserHistory.dart';
import 'package:indiflix/Splash/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../Onboarding Page/Genere selection/Components/GenreChips.dart';
import '../../../main.dart';
import '../../CustomListFromUserHistory/Model/History.dart';
import '../../DetailsPage/Components/DetailsPageBody.dart';
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
    late Timer timer;

  String primary_url =
      "https://api.themoviedb.org/3/discover/movie?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_genres=";
  String secondary_url =
      "https://api.themoviedb.org/3/movie/popular?api_key=ebe86eb4e04342d7598d4096a16d8d11&with_original_language=";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print("Remember movies" + remembermovies.toString());

    init();
    // print("Persistent Genre" + persistedGenres.toList().toString());
    //  print(FilterChipDisplay.filters.toList());
    //  print("Persistent languge" + persistedLanguages.toList().toString());

    //  print(LanguageSelection.languages.toList());
    print("Remember movies" + recommemdedmovies.toString());
      Timer.periodic(Duration(seconds: 5), (timer) {
        init();
        setState(() {});
    });
super.initState();
    // int count=FilterChipDisplay
  }
@override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    remembermovies = preferences.getStringList('savedmoviehistory') ?? [];
    recommemdedmovies = preferences.getStringList('saverecommendation') ?? [];
    recommemdedmovies = recommemdedmovies.reversed.toList();
    remembermovies = remembermovies.reversed.toList();

    persistedGenres = preferences.getStringList('_keygenres') ?? [];
    persistedLanguages = preferences.getStringList('_language') ?? [];
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
          remembermovies.isNotEmpty
              ? Container(
                  child: Column(
                    children: [
                      TopShimmerWithoutURL("Movies You Watched Recently"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 168.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: remembermovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> jsondetails =
                                json.decode(remembermovies[index]);
                            User user = User.fromJson(jsondetails);
                            //print(user.moviename.toString());
                            //print(user.url.toString());

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPageBody(
                                      moviename: user.moviename.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 118,
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //   color: Colors.white,
                                      ),
                                      height: 200,
                                      width: 120,
                                      child: user.url.toString().isEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/loading.png"),
                                                fit: BoxFit.cover,
                                              ))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                  user.url.toString(),
                                                  fit: BoxFit.cover),
                                            ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: 0.h,
                ),
          recommemdedmovies.isNotEmpty
              ? Container(
                  child: Column(
                    children: [
                      TopShimmerWithoutURL("Recommendations for you"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 168.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recommemdedmovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> jsondetails =
                                json.decode(recommemdedmovies[index]);
                            User user = User.fromJson(jsondetails);
                            //print(user.moviename.toString());
                            //print(user.url.toString());

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPageBody(
                                      moviename: user.moviename.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 118,
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //   color: Colors.white,
                                      ),
                                      height: 200,
                                      width: 120,
                                      child: user.url.toString().isEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/loading.png"),
                                                fit: BoxFit.cover,
                                              ))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                  user.url.toString(),
                                                  fit: BoxFit.cover),
                                            ),
                                    ),
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
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: 0.h,
                ),
          SplashScreen.saw == true
              ? persistedGenres.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: persistedGenres.length,
                      itemBuilder: (BuildContext context, int index) {
                        return getlatest(
                            persistedGenres[index].toString(),
                            primary_url +
                                fetch_genreid(persistedGenres[index])
                                    .toString(),
                            "");
                      })
                  : Container()
              : FilterChipDisplay.filters.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: FilterChipDisplay.filters.length,
                      itemBuilder: (BuildContext context, int index) {
                        return getlatest(
                            FilterChipDisplay.filters[index].toString(),
                            primary_url +
                                fetch_genreid(FilterChipDisplay.filters[index])
                                    .toString(),
                            "");
                      })
                  : Container(),
          SplashScreen.saw == true
              ? persistedLanguages.isNotEmpty
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
                  : Container()
              : LanguageSelection.languages.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: LanguageSelection.languages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return getlatest(
                            LanguageSelection.languages[index].toString(),
                            secondary_url +
                                fetchlanguage_code(
                                        LanguageSelection.languages[index])
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

  String fetch_genreid(String m) {
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
      ),
    );
  }

  Widget TopShimmerWithoutURL(name) {
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
        ],
      ),
    );
  }

  Widget gethead() {
    //appbar and searchbar
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                     Container(
                  height: 43,
                  width: 43,
                  child: Image(
                    color: Colors.pink,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/logot.png"),
                  )),
                Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: (Colors.grey[100])!,
                  direction: ShimmerDirection.ltr,
                  highlightColor: (Colors.grey[800])!,
                  child: Container(
                    margin: EdgeInsets.only(top: 3),
                    child: const Text(
                      "Dart Flix",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
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
