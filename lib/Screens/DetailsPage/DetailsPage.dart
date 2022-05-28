import 'package:flutter/material.dart';

import 'Components/DetailsPageBody.dart';



class DetailsPage extends StatelessWidget  {
  const DetailsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body:  DetailsPageBody(),      
    );
  }
}