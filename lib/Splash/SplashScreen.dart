import 'dart:async';

import 'package:flutter/material.dart';
import 'package:indiflix/Navigation/Navigation.dart';
import 'package:indiflix/Screens/Introduction%20Screen/IntroductionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Onboarding Page/Genere selection/GenreSelection.dart';

class SplashScreen extends StatefulWidget {
  static bool saw = false;

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
//(prefs.getBool('seen') ?? false);
    if (_seen) {
      SplashScreen.saw = _seen;
      _handleStartScreen();
    } else {
      SplashScreen.saw = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return IntroductionPage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future<void> _handleStartScreen() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return MyHomePage(userid: "userid");
      }),
      ModalRoute.withName('/Splash'),
    );
  }
}
