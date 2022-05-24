import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indiflix/Onboarding%20Page/Language%20Selection/components/LanguageChips.dart';
import 'package:indiflix/main.dart';

import 'package:sizer/sizer.dart';

import '../../../CustomSnackbar/Snackbar.dart';
import '../../../Util/RoundedRectenguarButton.dart';
import '../../Language Selection/LanguageSelection.dart';

class FilterChipDisplay extends StatefulWidget {
  static List<String> filters = [];

  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> genres_ids = {
      'Adventure': 12,
      'Fantasy': 14,
      'Animation': 16,
      'Drama': 18,
      'Horror': 27,
      'Action': 28,
      'Comedy': 35,
      'History': 36,
      'Western': 37,
      'Thriller': 53,
      'Crime': 80,
      'Documentary': 99,
      'Science Fiction': 878,
      'Mystery': 9648,
      'Music': 10402,
      'Romance': 10749,
      'Family': 10751,
      'War': 10752,
      'TV Movie': 10770,
    };
    // TODO: implement build
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
              child: Wrap(
            spacing: 5.0,
            runSpacing: 3.0,
            children: const <Widget>[
              filterChipWidget(chipName: 'Adventure'),
              filterChipWidget(chipName: 'Drama'),
              filterChipWidget(chipName: 'Horror'),
              filterChipWidget(chipName: 'Mystery'),
              filterChipWidget(chipName: 'War'),
              filterChipWidget(chipName: 'Romance'),
              filterChipWidget(chipName: 'Science Fiction'),
              filterChipWidget(chipName: 'Documentary'),
              filterChipWidget(chipName: 'Thriller'),
              filterChipWidget(chipName: 'Music'),
            ],
          )),
        ),
        SizedBox(
          height: 5.h,
        ),
        RoundedRectengularButton(
          text: "Continue",
          onPressed: () async {
            var _type = FeedbackType.success;
            Vibrate.feedback(_type);

            if (FilterChipDisplay.filters.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 5,
                  content: CustomSnackbr(
                    title: "oh Error!",
                    message: 'Select atleast one genre',
                  ),
                ),
              );
            } else {
              // print(FilterChipDisplay.filters.toList());
              preferences.setStringList(
                  "_keygenres", FilterChipDisplay.filters.toList());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return BuildLanguageSelection();
                }),
                ModalRoute.withName('/GenreSelection'),
              );
            }

            //  print(FilterChipDisplay._filters.toString());
            //Navigator.push(context, MaterialPageRoute(builder:  ((context) => const SkillsSelectionPage() )));
          },
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class filterChipWidget extends StatefulWidget {
  final String chipName;

  const filterChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

// ignore: camel_case_types
class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selectedColor: HexColor("#7220C9"),
      label: Text(widget.chipName),
      labelStyle: GoogleFonts.getFont(
        "Chivo",
        textStyle: TextStyle(
          color: _isSelected ? Colors.white : Colors.black,
          letterSpacing: .5,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: HexColor("#E5E5FF"),
      onSelected: (isSelected) {
        var _type = FeedbackType.selection;
        Vibrate.feedback(_type);
        setState(() {
          if (isSelected) {
            _isSelected = isSelected;
            FilterChipDisplay.filters.add(widget.chipName);
            // print( FilterChipDisplay._filters.toString());
          } else {
            _isSelected = false;

            FilterChipDisplay.filters.removeWhere((String name) {
              return name == widget.chipName;
            });
          }
        });
      },
    );
  }
}
