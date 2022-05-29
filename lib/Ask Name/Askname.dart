import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:indiflix/Onboarding%20Page/Genere%20selection/GenreSelection.dart';
import 'package:sizer/sizer.dart';

import '../Util/RoundedRectenguarButton.dart';
import '../main.dart';

  String stname = "";

class ask extends StatefulWidget {
  const ask({Key? key}) : super(key: key);

  @override
  State<ask> createState() => _askState();
}

class _askState extends State<ask> {

  TextEditingController _controller = TextEditingController();
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
            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 7.0),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //   identityLogo(),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Let us know you better",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(
                              color: Colors.white, fontFamily: "WorkSansLight"),
                          filled: true,
                          fillColor: Colors.white24,
                          hintText: 'Enter your name'),
                    ),
                    SizedBox(height: 10.h),

                    RoundedRectengularButton(
                      text: "Continue",
                      onPressed: () async {
                        var _type = FeedbackType.success;
                        Vibrate.feedback(_type);
                        if (_controller.text.isEmpty) {
                          _type = FeedbackType.error;
                          Vibrate.feedback(_type);
                          return;
                        } else {
                          // print(_controller.text);

                          stname=_controller.text;
                          preferences.setString(
                              "keyusername", _controller.text.toString());
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return GenreSelection();
                            }),
                            ModalRoute.withName('/ask'),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
