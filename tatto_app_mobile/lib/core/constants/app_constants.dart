import 'package:flutter/material.dart';

enum TattooStyle {
  blackwork,
  geometric,
  minimalist;

  String displayName() {
    final name = toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }
}

enum OutputLocation {
  leg,
  back,
  whitepaper;

  String displayName() {
    final name = toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }
}

enum ImageAspectRatio {
  square,
  portrait,
  landscape;

  String displayName() {
    final name = toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }

  String toJsonValue() {
    switch (this) {
      case square:
        return '1:1';
      case portrait:
        return '2:3';
      case landscape:
        return '3:2';
    }
  }
}

class AppConstants {
  static List<TattooStyle> get styles => TattooStyle.values;

  static List<OutputLocation> get outputLocations => OutputLocation.values;

  static List<ImageAspectRatio> get aspectRatios => ImageAspectRatio.values;

  static const Color primaryColor = Color(0xFFFF4B55);
  static const Color backgroundColor = Color(0xFF000000);
  static const Color surfaceColor = Color(0x1AFFFFFF); // white10
  static const Color white = Colors.white;
  static const Color disabledColor = Colors.white10;
  static const Color grey = Colors.black87;
}
