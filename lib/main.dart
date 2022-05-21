import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indiflix/Navigation/Navigation.dart';
import 'package:indiflix/Testing/Testing.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (BuildContext context, Orientation orientation,
        sizer.DeviceType deviceType) {
      return MaterialApp(
         useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
        theme: ThemeData(
          fontFamily: GoogleFonts.chivo().fontFamily,
        ),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // ignore: missing_required_param
        home: MyHomePage(),

        ///home: Show(),
      );
    });
  }
}
