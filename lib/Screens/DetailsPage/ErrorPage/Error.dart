import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
 const  ErrorPage({Key ?key}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '404',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    letterSpacing: 2,
                    color: Colors.white,
                    fontFamily: 'Anton',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'SORRY WE GOT SOME ERROR',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
