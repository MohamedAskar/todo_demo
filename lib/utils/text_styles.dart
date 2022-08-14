import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_demo/utils/color_styles.dart';

final appTextTheme = AppTextTheme();

class AppTextTheme {
  final TextStyle h1 = GoogleFonts.roboto(
    fontSize: 22,
    color: appColorTheme.darkBlue,
    fontWeight: FontWeight.w600,
  );
  final TextStyle dp16MedBlue = GoogleFonts.roboto(
    fontSize: 16,
    color: appColorTheme.darkBlue,
    fontWeight: FontWeight.w600,
  );
  final TextStyle dp18BoldWhite = GoogleFonts.roboto(
    fontSize: 18,
    color: appColorTheme.white,
    fontWeight: FontWeight.w700,
  );
  final TextStyle dp18BoldBlue = GoogleFonts.roboto(
    fontSize: 18,
    color: appColorTheme.darkBlue,
    fontWeight: FontWeight.w700,
  );
  final TextStyle dp16MedRed = GoogleFonts.roboto(
    fontSize: 16,
    color: appColorTheme.red,
    fontWeight: FontWeight.w600,
  );
  final TextStyle dp16MedWhite = GoogleFonts.roboto(
    fontSize: 16,
    color: appColorTheme.white,
    fontWeight: FontWeight.w600,
  );
}
