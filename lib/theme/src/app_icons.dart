import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  /// Define local assets
  static const String cinnamon = 'assets/icons/cinnamon_logo.svg';

  static const double sizeSmall = 22;
  static const double sizeMedium = 35;

  /// Check if the icon is SVG
  static bool isSvg(String path) => path.contains('svg');

  /// Return the icon accordingly
  static Widget icon(
    String path, {
    double size = sizeSmall,
    Color? color,
  }) {
    if (isSvg(path)) {
      return SvgPicture.asset(
        path,
        width: size,
        height: size,
        color: color,
      );
    } else {
      return Image.asset(
        path,
        width: size,
        height: size,
      );
    }
  }
}
