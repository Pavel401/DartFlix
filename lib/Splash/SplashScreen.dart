import 'dart:async';

import 'package:flutter/material.dart';
import 'package:indiflix/Navigation/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Onboarding Page/Genere selection/GenreSelection.dart';

class SplashScreen extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
//(prefs.getBool('seen') ?? false);
    if (_seen) {
      _handleStartScreen();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return GenreSelection();
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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(userid: "userid")));
  }
}
