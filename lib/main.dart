import 'package:flutter/material.dart';
import 'package:justicecorporate/screens/aboutus.dart';
import 'package:justicecorporate/screens/landingpage.dart';
import 'package:justicecorporate/screens/torchlight.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Landingpage(),
        '/aboutus': (context) => Aboutus(),
        '/torchlight': (context) => Torchlight(),
      },
    );
  }
}
