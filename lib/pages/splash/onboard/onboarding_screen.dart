// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pemira_app/config/app_assets.dart';
import './onboarding_step.dart';
import '../../home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentStep = 1;
  String imagePath = AppAssets.onboarding1;
  List<String> descriptions = [
    'Easy to understand voter education under the electoral act of the federation.',
    'Track your voter card and pollen unit easily.',
    'Report electoral violence, as quick as possible.',
    'Have fun while learning by playing games.',
  ];

  void nextStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep++;

        if (currentStep == 1) {
          imagePath = AppAssets.onboarding1;
        } else if (currentStep == 2) {
          imagePath = AppAssets.onboarding2;
        } else if (currentStep == 3) {
          imagePath = AppAssets.onboarding3;
        } else if (currentStep == 4) {
          imagePath = AppAssets.onboarding4;
        }
      });
    } else {
      // Move to the next page after the last step.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void skipOnboarding() {
    // Move to the next page when "Skip" is clicked.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingStep(
        currentStep: currentStep,
        descriptions: descriptions,
        imagePath: imagePath,
        onNext: nextStep,
        onSkip: skipOnboarding,
      ),
    );
  }
}
