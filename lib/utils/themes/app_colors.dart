import 'package:flutter/material.dart';

class AppColors
{
  static Color primary = const Color(0xff5893E8);
  static Color second = const Color(0xff8472c3);
  static Color backgroundLight = const Color(0xfff6f6f6);
  static Color backgroundDark = const Color(0xff505966);
  static Color selectLight = const Color(0xffE5C240);
  static Color selectDark = const Color(0xffA69556);

  static Color multipleColor1 = const Color(0xff0487D9);
  static Color multipleColor2 = const Color(0xff98A62D);
  static Color multipleColor3 = const Color(0xffF27405);
  static Color multipleColor4 = const Color(0xff9CE6C5);
  static Color multipleColor5 = const Color(0xff3F6655);

  static Color getRandomColor(){
    List<Color> colors = [
    Color(0xff0487D9),
    Color(0xff98A62D),
    Color(0xffF27405),
    Color(0xff9CE6C5),
    Color(0xff3F6655),
    ];
    colors.shuffle();
    return colors[0];
  }

  static List<Color> matchingPairsGradient = [
  Colors.blue.shade300,
  Colors.blue.shade600,
  ];

  static List<Color> multipleChoiceGradient = [
    Colors.purple.shade300,
    Colors.purple.shade600,
  ];
}