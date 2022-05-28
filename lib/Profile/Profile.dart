import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Screens/CustomListFromUserHistory/Model/History.dart';
import '../Screens/DetailsPage/Components/DetailsPageBody.dart';
import '../Util/RoundedBorderIcon.dart';
import '../main.dart';
import 'CircleHolder.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

dynamicChips() {
  if (persistedGenres.isEmpty)
    return Container(
      height: 50,
      child: const Center(child: CircularProgressIndicator()),
    );
  return Padding(
    padding: EdgeInsets.only(top: 2.h, right: 0.10.h, left: 2.h),
    child: Wrap(
      spacing: 5.w,
      runSpacing: 1.h,
      children: List<Widget>.generate(persistedGenres.length, (int index) {
        return Chip(
          label: Text(
            persistedGenres[index],
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          labelStyle: TextStyle(color: Colors.white),
          avatar: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.movie,
              color: Colors.white,
            ),
          ),
          labelPadding: EdgeInsets.all(4.0),
          backgroundColor: HexColor("#7220C9"),
        );
      }),
    ),
  );
}

dynamicChips2() {
  if (persistedLanguages.isEmpty)
    return Container(
      height: 50,
      child: const Center(child: CircularProgressIndicator()),
    );
  return Padding(
    padding: EdgeInsets.only(top: 2.h, right: 0.10.h, left: 2.h),
    child: Wrap(
      spacing: 5.w,
      runSpacing: 1.h,
      children: List<Widget>.generate(persistedLanguages.length, (int index) {
        return Chip(
          label: Text(
            persistedLanguages[index],
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          labelStyle: TextStyle(color: Colors.white),
          avatar: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.movie,
              color: Colors.white,
            ),
          ),
          labelPadding: EdgeInsets.all(4.0),
          backgroundColor: HexColor("#7220C9"),
        );
      }),
    ),
  );
}

class _ProfileState extends State<Profile> {
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    Timer.periodic(Duration(seconds: 10), (timer) {
      init();
      setState(() {});
    });
    super.initState();
    print(remembermovies.length);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    persistedGenres = preferences.getStringList('_keygenres') ?? [];
    persistedLanguages = preferences.getStringList('_language') ?? [];
    remembermovies = preferences.getStringList('savedmoviehistory') ?? [];
    recommemdedmovies = preferences.getStringList('saverecommendation') ?? [];
    recommemdedmovies = recommemdedmovies.reversed.toList();
    remembermovies = remembermovies.reversed.toList();

    username = preferences.getString('keyusername') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: HexColor("#272727"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      backgroundColor: HexColor("#121212"),
      body: Padding(
          padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleHolder(
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                        height: 80,
                        width: 80,
                        color: HexColor("#F1F1F1"),
                      ),
                    ]),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username.isNotEmpty ? username.toString() : "New USer",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ]),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Number of movies Watched",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        remembermovies.isNotEmpty
                            ? Text(
                                remembermovies.length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            : SizedBox(
                                width: 80.w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextScroll(
                                        "Grab a popcorn and watch some movies",
                                        velocity: Velocity(
                                            pixelsPerSecond: Offset(20, 0)),
                                        pauseBetween:
                                            Duration(milliseconds: 1000),
                                        mode: TextScrollMode.bouncing,
                                        style: TextStyle(
                                            color: HexColor("#DEDEDE"),
                                            fontSize: 20),
                                        textAlign: TextAlign.right,
                                        selectable: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 80.w,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextScroll(
                                  "Number of movies recommendations based on ML",
                                  velocity:
                                      Velocity(pixelsPerSecond: Offset(20, 0)),
                                  pauseBetween: Duration(milliseconds: 1000),
                                  mode: TextScrollMode.bouncing,
                                  style: TextStyle(
                                      color: HexColor("#DEDEDE"), fontSize: 20),
                                  textAlign: TextAlign.right,
                                  selectable: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        recommemdedmovies.isNotEmpty
                            ? Text(
                                recommemdedmovies.length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            : SizedBox(
                                width: 80.w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextScroll(
                                        "No data till now ",
                                        velocity: Velocity(
                                            pixelsPerSecond: Offset(20, 0)),
                                        pauseBetween:
                                            Duration(milliseconds: 1000),
                                        mode: TextScrollMode.bouncing,
                                        style: TextStyle(
                                            color: HexColor("#DEDEDE"),
                                            fontSize: 20),
                                        textAlign: TextAlign.right,
                                        selectable: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Preferred Genres",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ]),
                SizedBox(
                  height: 3.h,
                ),
                dynamicChips(),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Preferred Genres",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ]),
                dynamicChips2(),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Watching History",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ]),
                buildhistory(),
              ],
            ),
          )),
    );
  }

  Widget buildhistory() {
    return remembermovies.isNotEmpty
        ? Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: 168.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: remembermovies.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> jsondetails =
                          json.decode(remembermovies[index]);
                      User user = User.fromJson(jsondetails);
                      //print(user.moviename.toString());
                      //print(user.url.toString());

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPageBody(
                                moviename: user.moviename.toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 118,
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //   color: Colors.white,
                                ),
                                height: 200,
                                width: 120,
                                child: user.url.toString().isEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/loading.png"),
                                          fit: BoxFit.cover,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                            user.url.toString(),
                                            fit: BoxFit.cover),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        : SizedBox(
            height: 0.h,
          );
  }
}
