import 'package:flutter/material.dart';

class Routes {
  static const String home = 'home';
  static const String comicDetails = 'comic-details';
}

class Assets {
  static const String appIcon = 'lib/utils/resources/icons/app_icon.png';
}

class Const {
  static const double padding = 8;
  static const double borderRadius = 4;
}

class Screens {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}