// onboarding_step.dart
import 'package:flutter/material.dart';
import 'package:d_view/d_view.dart';

class OnboardingStep extends StatelessWidget {
  final int currentStep;
  final List<String> descriptions;
  final String imagePath;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingStep({
    super.key,
    required this.currentStep,
    required this.descriptions,
    required this.imagePath,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    double progressPercentage = (currentStep / descriptions.length) * 100;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              value: progressPercentage / 100,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          DView.height(23),
          Text('Step $currentStep/${descriptions.length}'),
          Text(descriptions[currentStep - 1]),
          Image.asset(imagePath),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onSkip,
                child: const Text('Skip'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: onNext,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
