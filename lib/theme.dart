import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xFF2C394B),
  primaryColorLight: const Color(0xFFFF4C29),
  primaryColor: const Color(0xFF5089C6),
  accentColor: const Color(0xFFFFAA4C),
  scaffoldBackgroundColor: const Color(0xFFEEEEEE),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
