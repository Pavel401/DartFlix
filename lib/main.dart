import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indiflix/Onboarding%20Page/Genere%20selection/GenreSelection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:device_preview/device_preview.dart';

import 'Onboarding Page/Language Selection/LanguageSelection.dart';
import 'Splash/SplashScreen.dart';

late SharedPreferences preferences;
List persistedGenres = [];
List persistedLanguages = [];
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    persistedGenres = preferences.getStringList('_keygenres') ?? [];
    persistedLanguages = preferences.getStringList('_language') ?? [];
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (BuildContext context, Orientation orientation,
        sizer.DeviceType deviceType) {
      return MaterialApp(
        routes: {
          '/GenreSelection': (context) => GenreSelection(),
          '/LanguageSelection': (context) => BuildLanguageSelection(),
                    '/Splash': (context) => SplashScreen(),

        },
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          fontFamily: GoogleFonts.chivo().fontFamily,
        ),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // ignore: missing_required_param
        home: SplashScreen(),

        ///home: Show(),
      );
    });
  }
}
