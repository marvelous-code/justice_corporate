import 'package:flutter/material.dart';
import 'package:justicecorporate/screens/aboutus.dart';
import 'package:justicecorporate/screens/batteries.dart';
import 'package:justicecorporate/screens/landingpage.dart';
import 'package:justicecorporate/screens/menu.dart';
import 'package:justicecorporate/screens/promo_page.dart';
import 'package:justicecorporate/screens/rechargeable_fans.dart';
import 'package:justicecorporate/screens/solar_panels.dart';
import 'package:justicecorporate/screens/torchlight.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions
            .currentPlatform, // Loads correct config for Android/iOS/Web
  );
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
        '/solarpanels': (context) => SolarPanels(),
        '/batteries': (context) => Batteries(),
        '/recharge': (context) => RechargeableFans(),
        '/menu': (context) => Menu(),
        '/promoPage': (context) => PromoPage(),
      },
    );
  }
}
