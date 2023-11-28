// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../config/app_assets.dart';
import 'onboard/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<String> images = [AppAssets.logo, AppAssets.logoNameWelcome];
  late int currentImageIndex;

  @override
  void initState() {
    super.initState();
    currentImageIndex = 0;

    // Add a delay for the first logo.
    Future.delayed(const Duration(seconds: 2), () {
      // Replace logo after delay and reset state.
      setState(() {
        currentImageIndex = 1;
      });

      // Add a delay for the second logo and move to the onboarding screen.
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEBEDEE),
              Color(0xFFFCFCFC),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            transform: GradientRotation(7 * 3.1416 / 180),
          ),
        ),
        child: Center(
          child: Image.asset(images[currentImageIndex]),
        ),
      ),
    );
  }
}
