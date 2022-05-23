import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'components/LanguageChips.dart';

class BuildLanguageSelection extends StatefulWidget {
  const BuildLanguageSelection({Key? key}) : super(key: key);

  @override
  State<BuildLanguageSelection> createState() => _BuildLanguageSelectionState();
}

class _BuildLanguageSelectionState extends State<BuildLanguageSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //   identityLogo(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Select your language",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Text(
                    "What languages will you be interested to watch?",
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  LanguageSelection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
