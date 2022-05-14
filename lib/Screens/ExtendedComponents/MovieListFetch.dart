import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:indiflix/Screens/DetailsPage/Components/DetailsPageBody.dart';
import 'package:shimmer/shimmer.dart';

class Latest extends StatefulWidget {
  final url;
  final id;
  final username;
  final recentname;
  const Latest(
      {Key? key, @required this.url, this.id, this.username, this.recentname})
      : super(key: key);

  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  List val = [];
  List watchlist = [];
  bool add = false;
  Future getpostdata() async {
    if (widget.id == null) return;
    final String url = "https://enage22.herokuapp.com/watch/" + widget.id;
    try {
      var response = await Dio().get(url);
      return response.data['post'];
    } catch (e) {
      print(e);
    }
  }

  Future getresponse() async {
    var response = await Dio().get(widget.url);
    var data = response.data;
    try {
      if (widget.recentname != "") {
        if (mounted) {
          setState(() {
            val = data;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            val = data["results"];
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
    this.getpostdata().then((value) => {
          if (mounted)
            {
              if (value == null || value.length == 0)
                {
                  setState(() {
                    watchlist = value;
                  })
                }
              else
                {
                  setState(() {
                    watchlist = value[0]['watchlist'];
                  }),
                }
            }
        });
  }

  Future postdata(movieid, moviename, posterpath) async {
    final String url = "https://enage22.herokuapp.com/saved/" +
        widget.id +
        "/" +
        movieid.toString();
    dynamic dat = {
      "userid": widget.id,
      "username": widget.username,
      "savedlist": [
        {
          "movieid": movieid.toString(),
          "moviename": moviename,
          "poster_path": posterpath
        }
      ]
    };
    try {
      await Dio().post(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: SizedBox(
                height: 140,
                width: 140,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Container(
                            child: Row(
                          children: [
                            const Icon(
                              Icons.playlist_add,
                              color: Colors.red,
                              size: 33,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 10),
                              padding: EdgeInsets.only(left: 5),
                              child: const Text(
                                "Add TO WATCHLIST",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ))),
                    InkWell(
                        onTap: () async {
                          await postdata(movieid, moviename, posterpath)
                              .then((val) => {
                                    Navigator.pop(context),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: Text("SAVED",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        action: SnackBarAction(
                                          label: 'Cancel',
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  });
                        },
                        child: Container(
                            child: Row(
                          children: [
                            const Icon(
                              Icons.bookmark,
                              color: Colors.red,
                              size: 32,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 5, left: 10),
                                padding: EdgeInsets.only(left: 5),
                                child: const Text(
                                  "SAVE THIS MOVIE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.white),
                                )),
                          ],
                        ))),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          
                        },
                        child: Container(
                            child: Text(
                          "CLOSE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )))
                  ],
                ))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (val == null) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 168.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: const Duration(milliseconds: 2000),
                  baseColor: (Colors.grey[700])!,
                  direction: ShimmerDirection.ltr,
                  highlightColor: (Colors.grey[500])!,
                  child: Container(
                    width: 118,
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    } else {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 168.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: val.length != null ? val.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPageBody(
                                    moviename: val[index]["original_title"],
                                   
                                  )));
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
                                ),
                                height: 165,
                                width: 120,
                                child: val[index]["poster_path"] == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: const Image(
                                          image:
                                              AssetImage("images/loading.png"),
                                          fit: BoxFit.cover,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: FadeInImage.assetNetwork(
                                          image:
                                              "https://image.tmdb.org/t/p/w500" +
                                                  val[index]["poster_path"],
                                          placeholder: "images/loading.png",
                                          fit: BoxFit.cover,
                                        ))),
                            Positioned(
                              top: 3,
                              right: 0,
                              child: GestureDetector(
                                  onTap: () {
                                    if (widget.id == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            height: 25,
                                            alignment: Alignment.center,
                                            child: const Text("PLEASE LOGIN",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          action: SnackBarAction(
                                            label: 'CANCEL',
                                            onPressed: () {
                                              // Code to execute.
                                            },
                                          ),
                                        ),
                                      );
                                    } else {
                                      _showMyDialog(
                                          val[index]["id"],
                                          val[index]["original_title"],
                                          val[index]["poster_path"]);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        )));
              }));
    }
  }
}
