// IM_2021_017 Sanduni Pandipperuma - Calculator Application

import 'package:flutter/material.dart';

import 'calculator_screen.dart';

// Entry point of the application
void main() {
  runApp(const MyApp());                    // Calls the MyApp widget to run the application
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});                // Constructor with a constant key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',                 // Tittle of the app
      theme: ThemeData.dark(),             // Applying a dark theme for the application
      home: const CalculatorScreen(),      // Sets CalculatorScreen as the home screen
      debugShowCheckedModeBanner: false,
    );
  }
}
