import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import '../DetailsPageBody.dart';

class Castdetails extends StatefulWidget {
  final castname;
  final profilepath;
  final castid;

  Castdetails({
    Key? key,
    @required this.castname,
    this.castid,
    this.profilepath,
  }) : super(key: key);

  @override
  _CastdetailsState createState() => _CastdetailsState();
}

class _CastdetailsState extends State<Castdetails> {
  List popularlist = [];
  void getpopularresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_cast=" +
            widget.castid.toString() +
            "&sort_by=vote_average.desc");

    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          popularlist = data["results"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Cast Details",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                height: 260,
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Container(
                      height: 230,
                      width: 160,
                      child: widget.profilepath == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/loading.png"),
                              ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                image: "https://image.tmdb.org/t/p/w780" +
                                    widget.profilepath,
                                fit: BoxFit.cover,
                                placeholder: "assets/images/loading.png",
                              )),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                          widget.castname,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              child: Text(
                "More Movies of  " + widget.castname.split(' ')[0],
                style: TextStyle(
                    color: HexColor("#7220C9"),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            getmovieslist()
          ],
        )));
  }

  Widget getlottie() {
    return Center(
      child: Lottie.asset("assets/images/loading_movie.json"),
    );
  }

  Widget getmovieslist() {
    if (popularlist.isEmpty) return getlottie();
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (115.0 / 190.0),
        ),
        shrinkWrap: true,
        itemCount: popularlist.length,
        controller: ScrollController(keepScrollOffset: false),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
                   var _type = FeedbackType.success;
                    Vibrate.feedback(_type);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPageBody(
                          moviename: popularlist[index]["original_title"])));
            },
            child: Container(
              height: 170,
              alignment: Alignment.center,
              padding: EdgeInsets.all(4.0),
              margin: EdgeInsets.all(2),
              child: popularlist[index]["poster_path"] == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/images/loading.png"),
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        fit: BoxFit.fitHeight,
                        width: double.infinity,
                        image: NetworkImage("https://image.tmdb.org/t/p/w780" +
                            popularlist[index]['poster_path']),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
