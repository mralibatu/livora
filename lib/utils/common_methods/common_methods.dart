import 'package:flutter/material.dart';

class CommonMethods{
  static Color getScoreColor(int score) {
    if(score > 80){
      return Colors.green;
    }else if(score > 60){
      return Colors.orange;
    }else if(score < 40){
      return Colors.red;
    }else{
      return Colors.grey;
    }
  }
}