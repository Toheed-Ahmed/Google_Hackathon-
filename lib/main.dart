import 'package:flutter/material.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(const OpsPilotApp());
}

class OpsPilotApp extends StatelessWidget {
  const OpsPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpsPilot AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1565C0),
        useMaterial3: true,
      ),
      home: const InputScreen(),
    );
  }
}