import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const backgroundColor = Color(0xFF0F0F3E);
  static const surfaceColor = Color(0xFF1A1A2E);
  static const accentColor = Color(0xFFE94560);
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.white70;

  static ThemeData get darkTheme => ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.urbanist(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    ),
    textTheme: GoogleFonts.urbanistTextTheme().apply(
      bodyColor: textPrimary,
      displayColor: textPrimary,
    ),
    colorScheme: const ColorScheme.dark(
      primary: accentColor,           // 🔥 Now this is used by `colorScheme.primary`
      secondary: Colors.tealAccent,   // Optional
      background: backgroundColor,
      surface: surfaceColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: GoogleFonts.urbanist(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
    cardColor: surfaceColor,
    dividerColor: Colors.white10,
    useMaterial3: true,
  );
}
