import 'package:flutter/material.dart';
import 'package:indiflix/Screens/MoreMoviesPage.dart/GetLists.dart';



class ListMovies extends StatefulWidget {
  final originalmoviename;
  final url;
  const ListMovies(
      {Key? key, required this.originalmoviename, required this.url})
      : super(key: key);

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            MoreMovies(
              url: widget.url + "&page=" + (1).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (2).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (3).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (4).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (5).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (6).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (8).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (9).toString(),
            ),
            MoreMovies(
              url: widget.url + "&page=" + (10).toString(),
            ),
          ],
        ),
      ),
    );
  }
}
