import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Screens/DetailsPage/Components/DetailsPageBody.dart';
import 'package:shimmer/shimmer.dart';

List val = [];

class HomeCarousle extends StatefulWidget {
  HomeCarousle({Key? key}) : super(key: key);

  @override
  _HomeCarousleState createState() => _HomeCarousleState();
}

class _HomeCarousleState extends State<HomeCarousle> {
  Future getresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/trending/all/day?api_key=ebe86eb4e04342d7598d4096a16d8d11");
    var data = response.data;

    try {
      setState(() {
        val = data["results"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
  }

  @override
  Widget build(BuildContext context) {
    if (val.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.38,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Shimmer.fromColors(
          period: const Duration(milliseconds: 2000),
          baseColor:  HexColor("#8970A4"),
          direction: ShimmerDirection.ltr,
          highlightColor:HexColor("#463567") ,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color:(Colors.purple[200])!, borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );
    }
    return CarouselSlider(
      items: [
        MovieCard(
          digit: 0,
        ),
        MovieCard(
          digit: 1,
        ),
        MovieCard(
          digit: 2,
        ),
        MovieCard(
          digit: 3,
        ),
        MovieCard(
          digit: 4,
        ),
        MovieCard(
          digit: 5,
        ),
        MovieCard(
          digit: 7,
        ),
      ],
      options: CarouselOptions(
        height: 250,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        // autoPlayCurve: Curves.fastOutSlowIn,
        // enlargeCenterPage: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        reverse: false,
      ),
    );
  }
}

class MovieCard extends StatefulWidget {
  final int digit;
  MovieCard({Key? key, required this.digit}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (val[widget.digit.toInt()]["original_title"] == null) {
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
         return   DetailsPageBody(
              moviename: val[widget.digit.toInt()]["original_title"],
            );
          }));
        }
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.fitWidth,
                image: "https://image.tmdb.org/t/p/original" +
                    val[widget.digit.toInt()]['poster_path'],
                placeholder: "images/loading.png",
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                  child: Text(
                val[widget.digit.toInt()]["original_title"] == null
                    ? ""
                    : val[widget.digit.toInt()]["original_title"],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )))
        ],
      ),
    );
  }
}