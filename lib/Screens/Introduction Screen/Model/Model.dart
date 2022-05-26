import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

List<PageViewModel> getPages() {
  return [
    PageViewModel(
      image: Stack(
        children: [
          Lottie.network(
              'https://assets7.lottiefiles.com/packages/lf20_nwfrjcrb.json',
              width: 500,
              height: 800),
          Lottie.asset('assets/images/browse.json', width: 500, height: 800),
        ],
      ),
      title: "Browse Over 4000+ Movies",
      body: "Grab a popcorn and enjoy the movies",
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
        bodyTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.w500,
            fontSize: 15.0),
        pageColor: Colors.transparent,
      ),
    ),
    PageViewModel(
      image: Stack(
        children: [
          Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
              width: 500,
              height: 800),
          Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_2cwDXD.json',
              width: 500,
              height: 800),
        ],
      ),
      title: "Get Recommendations Based on Your Preferences",
      body: "Watch your favorite movies and get recommendations",
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
        bodyTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.w500,
            fontSize: 15.0),
        pageColor: Colors.transparent,
      ),
    ),
    PageViewModel(
      image: Lottie.network(
          'https://assets5.lottiefiles.com/packages/lf20_yqnh895a.json',
          width: 500,
          height: 800),
      title: "Sentiment Analysis on Reviews",
      body: "Get the latest reviews and get the latest news",
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
        bodyTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.w500,
            fontSize: 15.0),
        pageColor: Colors.transparent,
      ),
    ),
    PageViewModel(
      image: Stack(
        children: [
          Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
              width: 500,
              height: 800),
          Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_1e1td9jb.json',
              width: 500,
              height: 800),
        ],
      ),
      title: "Random Movie Suggestions",
      body: "Get random movies to watch",
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
        bodyTextStyle: TextStyle(
            color: HexColor("#7220C9"),
            fontWeight: FontWeight.w500,
            fontSize: 15.0),
        pageColor: Colors.transparent,
      ),
    ),
  ];
}
