import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class RoundedRectengularButton extends StatelessWidget {
  final void Function() onPressed;
    String text="";
   RoundedRectengularButton({required this.onPressed,required this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w, // <-- Button Width
      height: 5.h, // <-- Button height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: HexColor("#4154FC"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
        ),
        onPressed: onPressed,
        child: Text(
        text,
          style: GoogleFonts.getFont(
            "Chivo",
            textStyle: const TextStyle(
              color: Colors.white,
              letterSpacing: .5,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}