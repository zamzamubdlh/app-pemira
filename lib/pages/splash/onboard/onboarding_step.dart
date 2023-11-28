import 'package:flutter/material.dart';
import 'package:d_view/d_view.dart';
import 'package:pemira_app/config/app_colors.dart';

class OnboardingStep extends StatelessWidget {
  final int currentStep;
  final List<String> descriptions;
  final List<String> imagePaths;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingStep({
    super.key,
    required this.currentStep,
    required this.descriptions,
    required this.imagePaths,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    double progressPercentage = (currentStep / descriptions.length) * 100;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 24,
          right: 16,
          bottom: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: LinearProgressIndicator(
                backgroundColor: const Color(0xFFE6E6E6),
                value: progressPercentage / 100,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColor.primary),
                minHeight: 8,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            DView.height(23),
            Text(
              descriptions[currentStep - 1],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColor.heading,
              ),
            ),
            Expanded(
              child: Center(
                child: Image.asset(imagePaths[currentStep - 1]),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSkip,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        const Size.fromHeight(46),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        AppColor.light,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: AppColor.dark,
                      ),
                    ),
                  ),
                ),
                DView.width(21), // Jarak antara tombol
                Expanded(
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        AppColor.primary,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        DView.width(4),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
