import 'package:flutter/material.dart';

class GradientModel{

  Color topColor;
  Color bottomColor;
  String topColorCode;
  String bottomColorCode;

  GradientModel(
      {this.topColor,
        this.bottomColor,
        this.topColorCode,
        this.bottomColorCode});

  setTopColor({Color color}){
    topColor = color;
  }

  setBottomColor({Color color}){
    bottomColor = color;
  }

  setTopColorCode({String colorCode}){
    topColorCode = colorCode;
  }

  setBottomColorCode({String colorCode}){
    bottomColorCode = colorCode;
  }

  Color getTopColor(){
    return topColor;
  }

  Color getBottomColor(){
    return bottomColor;
  }

  String getTopColorCode(){
    return topColorCode;
  }

  String getBottomColorCode(){
    return bottomColorCode;
  }
}