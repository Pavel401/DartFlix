import 'package:flutter/material.dart';
import 'package:indiflix/Swipable%20Cards/components/CustomCard.dart';

class SwipableCards extends StatelessWidget {
  const SwipableCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CustomCard(title: "Avatar", relase_data: "2022-05-13", rating: "8.5", url: "https://image.tmdb.org/t/p/w500/gC3tW9a45RGOzzSh6wv91pFnmFr.jpg"),
      ),
    );
  }
}
