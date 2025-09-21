import 'package:flutter/material.dart' show SizedBox;

class AppSpacing {
  AppSpacing._();

  static const double s05 = 2;
  static const double s1 = 4;
  static const double s15 = 6;
  static const double s2 = 8;
  static const double s25 = 10;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s45 = 18;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s7 = 28;
  static const double s8 = 32;
  static const double s10 = 40;
  static const double s12 = 48;
  static const double s20 = 80;

  static const SizedBox w1 = SizedBox(width: s1);
  static const SizedBox w2 = SizedBox(width: s2);
  static const SizedBox w3 = SizedBox(width: s3);
  static const SizedBox w4 = SizedBox(width: s4);

  static const SizedBox h1 = SizedBox(height: s1);
  static const SizedBox h2 = SizedBox(height: s2);
  static const SizedBox h3 = SizedBox(height: s3);
  static const SizedBox h4 = SizedBox(height: s4);
}
