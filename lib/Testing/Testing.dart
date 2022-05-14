import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sizer/sizer.dart';

import '../Screens/DetailsPage/Components/Cast Details/CastDetails.dart';


class Testing extends StatefulWidget {
  

  const Testing({ Key? key }) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
  
  List production_companies=[];
    List moviedetails = [];
    List genres=[];
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
                  backgroundColor: const Color.fromRGBO(222, 49, 99, 1),
                  elevation: 2.0,
                ),
              );
            }));
  }  
  void getpopularresponse() async {
    var response = await Dio().get("https://enage22.herokuapp.com/getmovie/Avatar");
    var data = response.data;
    try {
      setState(() {
        genres = data["genres"];
      });
    } catch (e) {
      print(e);
    }
  }
  
        void initState() {
    super.initState();
    getpopularresponse();
  }

    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            

          }, child: Text("fetch")),

          getgenres(),
        ],
      ),
      
    );

  }
  
}