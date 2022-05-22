import 'package:flutter/material.dart';
import 'package:indiflix/Screens/Genre%20List/Components/FetchMovies.dart';

class BuildMoviesList extends StatefulWidget {
  final genre;
  final id;
  const BuildMoviesList({Key? key, required this.genre, this.id}) : super(key: key);

  @override
  State<BuildMoviesList> createState() => _BuildMoviesListState();
}

class _BuildMoviesListState extends State<BuildMoviesList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            fetchGenreData(
              id: this.widget.id.toString(),
              genre: this.widget.genre.toString(),
              page: "1",
            ),
            fetchGenreData(
               id: this.widget.id.toString(),
              genre: this.widget.genre.toString(),
              page: "2",
            ),
             fetchGenreData(
                id: this.widget.id.toString(),
              genre: this.widget.genre.toString(),
              page: "5",
            ),
            fetchGenreData(
               id: this.widget.id.toString(),
              genre: this.widget.genre.toString(),
              page: "3",
            ),
            fetchGenreData(
               id: this.widget.id.toString(),
              genre: this.widget.genre.toString(),
              page: "4",
            ),
           
            
          ],
        ),
      ),
    );
  }
}
