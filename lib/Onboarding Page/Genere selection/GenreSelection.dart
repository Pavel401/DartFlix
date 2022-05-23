import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Components/GenreChips.dart';

class GenreSelection extends StatefulWidget {
  const GenreSelection({Key? key}) : super(key: key);

  @override
  State<GenreSelection> createState() => _GenreSelectionState();
}

class _GenreSelectionState extends State<GenreSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,

        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Let's get to know you better",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const Text(
                        "What genres will you be interested to watch?",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      FilterChipDisplay(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
