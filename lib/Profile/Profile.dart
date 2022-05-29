import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Ask Name/Askname.dart';
import '../Onboarding Page/Genere selection/Components/GenreChips.dart';
import '../Onboarding Page/Language Selection/components/LanguageChips.dart';
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
  return persistedGenres.isNotEmpty
      ? Padding(
          padding: EdgeInsets.only(top: 2.h, right: 0.10.h, left: 2.h),
          child: Wrap(
            spacing: 5.w,
            runSpacing: 1.h,
            children:
                List<Widget>.generate(persistedGenres.length, (int index) {
              return Chip(
                label: Text(
                  persistedGenres[index],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
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
        )
      : FilterChipDisplay.filters.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(top: 2.h, right: 0.10.h, left: 2.h),
              child: Wrap(
                spacing: 5.w,
                runSpacing: 1.h,
                children: List<Widget>.generate(
                    FilterChipDisplay.filters.length, (int index) {
                  return Chip(
                    label: Text(
                      persistedGenres[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
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
            )
          : Container();
}

dynamicChips2() {
  return persistedLanguages.isNotEmpty
      ? Padding(
          padding: EdgeInsets.only(top: 2.h, right: 0.10.h, left: 2.h),
          child: Wrap(
            spacing: 5.w,
            runSpacing: 1.h,
            children:
                List<Widget>.generate(persistedLanguages.length, (int index) {
              return Chip(
                label: Text(
                  persistedLanguages[index],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
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
        )
      : LanguageSelection.languages.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(top: 2.h, right: 0.10.h, left: 2.h),
              child: Wrap(
                spacing: 5.w,
                runSpacing: 1.h,
                children: List<Widget>.generate(
                    LanguageSelection.languages.length, (int index) {
                  return Chip(
                    label: Text(
                      persistedLanguages[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
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
            )
          : Container();
}

class _ProfileState extends State<Profile> {
  late Timer timer;

  void initState() {
    // TODO: implement initState
    super.initState();

    //print("searched movies" + searchdata.toString());

    init();

    Timer.periodic(Duration(seconds: 8), (timer) {
      init();
      setState(() {});
    });
       super.initState();

    // int count=FilterChipDisplay
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    username = preferences.getString('keyusername') ?? "";
    persistedGenres = preferences.getStringList('_keygenres') ?? [];
    persistedLanguages = preferences.getStringList('_language') ?? [];
    preferences = await SharedPreferences.getInstance();
    remembermovies = preferences.getStringList('savedmoviehistory') ?? [];
    recommemdedmovieimages =
        preferences.getStringList('recommemdedmovieimages') ?? [];
    recommemdedmovienames =
        preferences.getStringList('recommemdedmovietitles') ?? [];
    recommemdedmovieimages = recommemdedmovieimages.reversed.toList();
    recommemdedmovienames = recommemdedmovienames.reversed.toList();
    remembermovies = remembermovies.reversed.toList();
    searchdata = preferences.getStringList('searchdatas') ?? [];
    searchdata = searchdata.reversed.toList();
    images = preferences.getStringList('posters') ?? [];
    title = preferences.getStringList('movienames') ?? [];
    images = images.reversed.toList();
    title = title.reversed.toList();
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
                        username.isNotEmpty
                            ? username.toString()
                            : stname.toString(),
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
                        checkremember(),
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
                        checkrecommend(),
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
                images.isNotEmpty
                    ? buildhistory()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Text(
                              "No Data till now",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ]),
              ],
            ),
          )),
    );
  }

  Widget buildhistory() {
    if (images.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: 168.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
              period: const Duration(milliseconds: 2000),
              baseColor: HexColor("#8970A4"),
              direction: ShimmerDirection.ltr,
              highlightColor: HexColor("#463567"),
              child: Container(
                width: 118,
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    color: (Colors.purple[200])!,
                    borderRadius: BorderRadius.circular(4.0)),
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: 168.0,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPageBody(
                            moviename: title[index].toString())));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10.h,
                  width: 35.w,
                  child: images.toString().isEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const Image(
                            image: AssetImage("assets/images/loading.png"),
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FadeInImage.assetNetwork(
                            image: images[index].toString(),
                            placeholder: "assets/images/loading.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  bool t = true;
  Widget checkremember() {
    return images.isNotEmpty
        ? Text(
            images.length.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          )
        : SizedBox(
            width: 80.w,
            child: Row(
              children: [
                Expanded(
                  child: TextScroll(
                    "Grab a popcorn and watch some movies",
                    velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
                    pauseBetween: Duration(milliseconds: 1000),
                    mode: TextScrollMode.bouncing,
                    style: TextStyle(color: HexColor("#DEDEDE"), fontSize: 20),
                    textAlign: TextAlign.right,
                    selectable: false,
                  ),
                ),
              ],
            ),
          );
  }

  Widget checkrecommend() {
    return recommemdedmovienames.isNotEmpty
        ? Text(
            recommemdedmovienames.length.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          )
        : SizedBox(
            width: 80.w,
            child: Row(
              children: [
                Expanded(
                  child: TextScroll(
                    "No data till now ",
                    velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
                    pauseBetween: Duration(milliseconds: 1000),
                    mode: TextScrollMode.bouncing,
                    style: TextStyle(color: HexColor("#DEDEDE"), fontSize: 20),
                    textAlign: TextAlign.right,
                    selectable: false,
                  ),
                ),
              ],
            ),
          );
  }

  List<String> dk = [
    "https://res.cloudinary.com/dc0tfxkph/image/upload/v1653673099/heroku.png",
    "https://res.cloudinary.com/dc0tfxkph/image/upload/v1653673099/heroku.png",
    "https://res.cloudinary.com/dc0tfxkph/image/upload/v1653673099/heroku.png",
    "https://res.cloudinary.com/dc0tfxkph/image/upload/v1653673099/heroku.png",
    "https://res.cloudinary.com/dc0tfxkph/image/upload/v1653673099/heroku.png",
  ];
}
