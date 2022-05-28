import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hexcolor/hexcolor.dart';

class Reviews extends StatefulWidget {
  final id;
  final moviename;
  Reviews({Key? key, @required this.id, this.moviename}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List reviews = [];
  void fetchreviews() async {
    var response = await Dio()
        .get("https://enage22.herokuapp.com//getreview/" + widget.moviename);
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          reviews = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchreviews();
  }

  Widget build(BuildContext context) {
    if (reviews.isEmpty) return Center(child: CircularProgressIndicator());
    if (reviews.length == 0) {
      return Center(
          child: Text("There's no public review available yet",
              style: TextStyle(color: HexColor("#7220C9"), fontSize: 30)));
    }
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 20,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: reviews[index]['rating'] == "Good"
                        ? HexColor("#2FC162")
                        : HexColor("#B02A2D"),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            reviews[index]["review"],
                            maxLines: 12,
                            style: TextStyle(
                              fontFamily: 'fonts/Lato-Bold.ttf',
                              decoration: TextDecoration.none,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 4, bottom: 5),
                            child: Text(
                                (reviews[index]['rating'] == "Good"
                                    ? "Good review"
                                    : "Bad Review"),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 4, bottom: 5),
                            child: Text(
                                (reviews[index]['rating'] == "Good"
                                    ? " 👍 "
                                    : " 👎 "),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
