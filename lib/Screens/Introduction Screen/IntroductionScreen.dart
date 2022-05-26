import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'Components/IntroductionScreenBody.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({ Key ?key }) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
     
      resizeToAvoidBottomInset: false,
      body: IntroductionScreenBody(),
    );
  }
}