import 'package:flutter/material.dart';
import 'package:indiflix/Navigation/Navigation.dart';
import 'package:indiflix/Onboarding%20Page/Genere%20selection/GenreSelection.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../Model/Model.dart';

class IntroductionScreenBody extends StatefulWidget {
  const IntroductionScreenBody({Key? key}) : super(key: key);

  @override
  _IntroductionScreenBodyState createState() => _IntroductionScreenBodyState();
}

class _IntroductionScreenBodyState extends State<IntroductionScreenBody> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.transparent,
      //color: kPrimaryLightColor,
      pages: getPages(),
      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return GenreSelection();
            },
          ),
        ); // When done button is press
      },

      showSkipButton: false,
      skip: Text(
        "Skip",
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      next: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      done: const Text("Done",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.purple,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
