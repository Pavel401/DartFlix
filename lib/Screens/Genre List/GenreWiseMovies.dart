import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Components/BuildMovieList.dart';
import 'Components/FetchMovies.dart';


class GenreWiseMovies extends StatelessWidget {
   final genre;
   final id;

  const GenreWiseMovies({ Key? key,required this.genre,required this.id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: HexColor("#121212"),
        appBar: AppBar(
          backgroundColor: HexColor("#272727"),
          title: Text(
            this.genre,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
      body: BuildMoviesList(genre: genre.toString(),id: id.toString(),),
    );
  }
}