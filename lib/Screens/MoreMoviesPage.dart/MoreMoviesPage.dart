import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Screens/MoreMoviesPage.dart/Components/MoreMoviesPageBody.dart';


class MoreMoviesPage extends StatelessWidget {
   final originalmoviename;
  final url;
  const MoreMoviesPage({ Key? key,required this.originalmoviename,required this.url }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: HexColor("#121212"),
        appBar: AppBar(
          backgroundColor: HexColor("#272727"),
          title: Text(
            this.originalmoviename,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
      body: ListMovies(originalmoviename: originalmoviename, url: url),
    );
  }
}