// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pemira_app/config/app_assets.dart';
import 'package:pemira_app/pages/auth/register_screen.dart';
import './onboarding_step.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentStep = 1;
  List<String> descriptions = [
    'Easy to understand voter education under the electoral act of the federation.',
    'Track your voter card and pollen unit easily.',
    'Report electoral violence, as quick as possible.',
    'Have fun while learning by playing games.',
  ];

  List<String> imagePaths = [
    AppAssets.onboarding1,
    AppAssets.onboarding2,
    AppAssets.onboarding3,
    AppAssets.onboarding4,
  ];

  void nextStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep++;
      });
    } else {
      // Move to the next page after the last step.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
      );
    }
  }

  void skipOnboarding() {
    // Move to the next page when "Skip" is clicked.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingStep(
        currentStep: currentStep,
        descriptions: descriptions,
        imagePaths: imagePaths,
        onNext: nextStep,
        onSkip: skipOnboarding,
      ),
    );
  }
}
