import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';

class CandidatesScreen extends StatelessWidget {
  const CandidatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Candidates',
                            style: GoogleFonts.openSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              Text(
                'Candidates',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: AppColor.heading,
                ),
              ),
              const SizedBox(height: 32),
              _buildMenuItem(
                  'Candidate Registration', Icons.app_registration_outlined,
                  () {
                Navigator.pushNamed(context, '/auth/candidates/registration');
              }),
              _buildMenuItem('Candidate Profile', Icons.person_pin_outlined,
                  () {
                Navigator.pushNamed(context, '/auth/account/previous_vote');
              }),
              _buildMenuItem('Debates & Presentation', Icons.info, () {
                Navigator.pushNamed(
                    context, '/auth/candidates/debates_presentation');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String text, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColor.sentence,
                  width: 0.5,
                ),
                bottom: BorderSide(
                  color: AppColor.sentence,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColor.heading,
                  ),
                ),
                Icon(
                  icon,
                  color: AppColor.heading,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
