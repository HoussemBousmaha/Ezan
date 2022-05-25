import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenHeight;
  static late double screenWidth;
  static const figmaHeight = 896;
  static const figmaWidth = 414;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  static double height(double height) {
    return height * screenHeight / figmaHeight;
  }

  static double width(double width) {
    return width * screenWidth / figmaWidth;
  }

  static Widget addVerticalSpace(double inputHeight) {
    return SizedBox(
      height: height(inputHeight),
    );
  }

  static Widget addHorizontalSpace(double inputWidth) {
    return SizedBox(
      width: width(inputWidth),
    );
  }
}
