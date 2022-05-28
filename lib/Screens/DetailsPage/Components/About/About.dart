import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../Cast Details/CastDetails.dart';

class About extends StatefulWidget {
  final overview;
  final id;
  final moviename;
  final userid;
  final username;
  final production_companies;
  About(
      {Key? key,
      @required this.overview,
      this.id,
      this.moviename,
      this.userid,
      this.production_companies,
      this.username})
      : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  List genres = [];
  List production_companies = [];
  List moviedetails = [];
  List director = [];
  List crew = [];

  void getmoviedetails() async {
    try {
      var response = await Dio()
          .get("https://enage22.herokuapp.com/getmovie/" + widget.moviename);
      var data = response.data;

      setState(() {
        moviedetails = data;
      });
    } catch (e) {}
  }

  void getpopularresponse() async {
    var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
        widget.id.toString() +
        "?api_key=360a9b5e0dea438bac3f653b0e73af47&language=en-US");
    var data = response.data;
    try {
      setState(() {
        genres = data["genres"];
      });
    } catch (e) {
      print(e);
    }
  }

  void getcompanies() async {
    var response = await Dio()
        .get("https://enage22.herokuapp.com/getmovie/" + widget.moviename);
    var data = response.data;

    try {
      setState(() {
        production_companies = data["production_companies"];
      });
    } catch (e) {
      print(e);
    }
  }

  void getcrewdetails() async {
    var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
        widget.id.toString() +
        "/credits?api_key=8b5da40bcd2b5fa4afe55c468001ad8a");
    var data = response.data;
    try {
      setState(() {
        crew = data["cast"];
      });
    } catch (e) {
      print(e);
    }
  }

  void getdirector() async {
    var response = await Dio()
        .get("https://enage22.herokuapp.com/getdirector/" + widget.moviename);
    var data = response.data;
    try {
      setState(() {
        director = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getpopularresponse();
    getmoviedetails();
    getdirector();
    getcrewdetails();
    getcompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getoverview(),
            Container(
                margin:
                    EdgeInsets.only(left: 2.w, right: 2.w, top: 10, bottom: 8),
                child: Text(
                  widget.overview,
                  style: TextStyle(
                      wordSpacing: 0.8.w,
                      //fontFamily: 'fonts/Lato-Bold.ttf',
                      color: Colors.grey[200],
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      decoration: TextDecoration.none),
                )),
            getgenrehead(),
            getgenres(),
            getdetails(),
            getdetailslist(),
            SizedBox(
              height: 2.h,
            ),
            getcrewname(),
            getcrew(),
            SizedBox(
              height: 2.h,
            ),
            getproduction_companies(),
            getproduction_companies_chips(),
          ],
        )));
  }

  Widget getcrew() {
    if (crew.isEmpty) return const Center(child: CircularProgressIndicator());
    if (crew.length == 0)
      return Center(
          child: Container(
        child: const Text(
          "NO CREW DETAILS AVAILABLE",
          style: TextStyle(color: Colors.white),
        ),
      ));
    return Container(
        margin: const EdgeInsets.only(top: 10),
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: crew.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    var _type = FeedbackType.success;
                    Vibrate.feedback(_type);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Castdetails(
                                  castname: crew[index]['name'],
                                  castid: crew[index]['id'],
                                  profilepath: crew[index]['profile_path'],
                                )));
                  },
                  child: Container(
                      width: 100,
                      margin: const EdgeInsets.all(3),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 120,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(crew[index]
                                                ["profile_path"] ==
                                            null
                                        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR28i5jWF37DvM01csPLTUTxEvCUAiL1ho6qw&usqp=CAU"
                                        : "https://image.tmdb.org/t/p/original" +
                                            crew[index]["profile_path"]),
                                  ))),
                          Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                      crew[index]["original_name"]
                                                  .split(" ")[0] ==
                                              null
                                          ? ""
                                          : crew[index]["original_name"]
                                              .split(" ")[0],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))))
                        ],
                      )));
            }));
  }

  Widget getdetailslist() {
    if (moviedetails.isEmpty || director.isEmpty) {
      return const SizedBox(
          height: 200, child: Center(child: CircularProgressIndicator()));
    }
    return Container(
        margin: EdgeInsets.only(left: 2.w, top: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(Icons.person, color: Colors.),
                Text("Director :",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h, right: 22.w),
                  child: Text((director.isEmpty ? "" : director[0]),
                      style: TextStyle(
                        wordSpacing: 0.8.w,
                        //fontFamily: 'fonts/Lato-Bold.ttf',
                        color: Colors.grey[200],
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(Icons.person, color: Colors.),
                Text("Run Time :",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h, right: 30.w),
                  child: Text(
                      (moviedetails[0]['runtime'].toString().isEmpty
                          ? "NO data"
                          : moviedetails[0]['runtime'].toString() + " minutes"),
                      style: TextStyle(
                        wordSpacing: 0.8.w,
                        //fontFamily: 'fonts/Lato-Bold.ttf',
                        color: Colors.grey[200],
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(Icons.person, color: Colors.),
                Text("Release Date : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h, right: 30.w),
                  child: Text(
                      (moviedetails[0]['release_date'].toString().isEmpty
                          ? "NO data"
                          : moviedetails[0]['release_date']),
                      style: TextStyle(
                        wordSpacing: 0.8.w,
                        //fontFamily: 'fonts/Lato-Bold.ttf',
                        color: Colors.grey[200],
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(Icons.person, color: Colors.),
                Text("Popularity :",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h, right: 34.w),
                  child: Text(
                      (moviedetails[0]['popularity'].toString().isEmpty
                          ? "NO data"
                          : moviedetails[0]['popularity'].toString()),
                      style: TextStyle(
                        wordSpacing: 0.8.w,
                        //fontFamily: 'fonts/Lato-Bold.ttf',
                        color: Colors.grey[200],
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      )),
                ),
              ],
            ),
          ],
        ));
  }

  Widget getdetails() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 8,
      ),
      child: const Text("Details",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getproduction_companies() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 8,
      ),
      child: const Text("Production Companies",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getcrewname() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 8, bottom: 5),
      child: const Text("Crew",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getoverview() {
    return Container(
      margin: EdgeInsets.only(
        top: 1.h,
        left: 2.w,
      ),
      child: const Text(
        "Overview",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none),
      ),
    );
  }

  Widget getgenrehead() {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 8),
      child: const Text("Genre",
          style: TextStyle(
              // fontFamily: 'fonts/Lato-Bold.ttf',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getgenres() {
    if (genres.isEmpty)
      return Container(
        height: 50,
        child: const Center(child: CircularProgressIndicator()),
      );

    return Container(
        height: 50.0,
        margin: const EdgeInsets.only(top: 8),
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Chip(
                  //   labelPadding: EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Text(genres[index]['name'][0],
                        style: const TextStyle(
                            fontFamily: 'fonts/Lato-Bold.ttf',
                            color: Colors.black,
                            fontSize: 18,
                            decoration: TextDecoration.none)),
                  ),
                  label: Text(genres[index]['name'],
                      style: const TextStyle(
                          // fontFamily: 'fonts/Lato-Bold.ttf',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none)),
                  backgroundColor: HexColor("#7220C9"),
                  elevation: 2.0,
                ),
              );
            }));
  }

  Widget getproduction_companies_chips() {
    if (widget.production_companies.isEmpty)
      return Container(
        height: 50,
        child: const Center(child: CircularProgressIndicator()),
      );

    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.production_companies.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 3.w, right: 2.w, bottom: 5.h),
            child: Chip(
              //   labelPadding: EdgeInsets.all(2.0),
              avatar: CircleAvatar(
                backgroundColor: Colors.white70,
                child: Text(
                    widget.production_companies[index]["name"] == null
                        ? ""
                        : widget.production_companies[index]["name"][0],
                    style: const TextStyle(
                        fontFamily: 'fonts/Lato-Bold.ttf',
                        color: Colors.black,
                        fontSize: 18,
                        decoration: TextDecoration.none)),
              ),
              label: Text(
                  widget.production_companies[index]["name"] == null
                      ? ""
                      : widget.production_companies[index]["name"],
                  style: const TextStyle(
                      // fontFamily: 'fonts/Lato-Bold.ttf',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
              backgroundColor: HexColor("#7220C9"),
              elevation: 2.0,
            ),
          );
        },
      ),
    );
  }
}
