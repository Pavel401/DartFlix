import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Screens/Genre%20List/GenreWiseMovies.dart';

import 'Searchqueryshow.dart';

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({Key? key}) : super(key: key);

  @override
  State<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  @override
  List movie_data = [
    {"name": "top", "color": Colors.red, "image": "images/action.jpg"},
    {"name": "Bollywood", "color": Colors.blue, "image": "images/adventu.jpg"},
    {"name": "Folk", "color": Colors.green, "image": "images/animation.jpg"},
    {"name": "Hip Hop", "color": Colors.yellow, "image": "images/comedy.jpg"},
    {"name": "top", "color": Colors.pink, "image": "images/crime.jpg"},
    {
      "name": "Bollywood",
      "color": Colors.pinkAccent,
      "image": "images/doc.jpg"
    },
    {"name": "Folk", "color": Colors.indigo, "image": "images/dram.jpg"},
    {
      "name": "Hip Hop",
      "color": Colors.deepOrangeAccent,
      "image": "images/family.jpg"
    },
    {"name": "Hip Hop", "color": Colors.purple, "image": "images/fantasy.jpg"},
    {
      "name": "top",
      "color": Colors.lightGreenAccent,
      "image": "images/history.jpg"
    },
    {
      "name": "Bollywood",
      "color": Colors.blueGrey,
      "image": "images/horror.jpg"
    },
    {"name": "Folk", "color": Colors.green[200], "image": "images/music.jpg"},
    {
      "name": "Hip Hop",
      "color": Colors.tealAccent,
      "image": "images/mystery.jpg"
    },
    {
      "name": "top",
      "color": Colors.deepPurpleAccent,
      "image": "images/romance.jpg"
    },
  ];

  List val = [];

  Future fetchresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=ebe86eb4e04342d7598d4096a16d8d11&language=en-US");
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          val = data["genres"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    fetchresponse();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getappbar(),
            searchbar(),
            gettopgeneres(),
            //gettopgeneresname(),
          ],
        ),
      ),
    );
  }

  Widget getappbar() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            "Search Movies",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchbar() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Searchnames(
                         
                        )));
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            suffixIcon: Icon(
              Icons.search,
              color: HexColor("#7220C9"),
            )),
      ),
    );
  }

  Widget gettopgeneres() {
    if (val.isEmpty)
      return Container(
        child: ListView.builder(
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: ((context, index) => VideoShimmer(
                  isPurplishMode: true,
                  isDarkMode: true,
                ))),
      );
    else
      return Container(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (140.0 / 70.0),
              ),
              shrinkWrap: true,
              itemCount: 14,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GenreWiseMovies(genre: val[index]["name"],id:val[index]["id"] ,),
                        ),
                      );
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        margin: EdgeInsets.all(3.3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  colorBlendMode: BlendMode.modulate,
                                  fit: BoxFit.cover,
                                  image: AssetImage(movie_data[index]["image"]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(val[index]["name"],
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        )));
              }));
  }
}
