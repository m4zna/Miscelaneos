import 'package:flutter/material.dart';

class AppTheme{
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,

    textTheme: const TextTheme(
      // titleLarge: GoogleFonts.montserratAlternates(),
      // titleMedium: GoogleFonts.montserratAlternates(fontSize: 25),
    )
  );
}