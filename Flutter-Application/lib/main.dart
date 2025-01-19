import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/landing_screen.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const ArtBlockApp());
}

class ArtBlockApp extends StatelessWidget {
  const ArtBlockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArtBlock',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          displayMedium: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
          displaySmall: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          headlineLarge: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
          headlineMedium: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          headlineSmall: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          titleLarge: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          titleMedium: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          titleSmall: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          bodyLarge: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          bodyMedium: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          bodySmall: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
      home: const LandingScreen(),
    );
  }
}
