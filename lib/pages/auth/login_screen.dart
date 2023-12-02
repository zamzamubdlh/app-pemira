import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:d_view/d_view.dart';
import 'package:pemira_app/config/app_assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/pages/home.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final editName = TextEditingController();
  final editEmail = TextEditingController();
  final editPhone = TextEditingController();
  final editPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DView.height(14),
            Image.asset(
              AppAssets.logoName,
            ),
            DView.height(16),
            Text(
              'Login',
              style: GoogleFonts.playfairDisplay(
                fontSize: 40,
                color: AppColor.heading,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            DView.height(12),
            Text(
              'Provide your account information to login.',
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: AppColor.sentence,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
            ),
            DView.height(16),
            _buildTextFieldWithLabelAndIcon(
              'Email',
              'Input your email here',
              Icons.email,
            ),
            DView.height(16),
            _buildTextFieldWithLabelAndIcon(
              'Password',
              'Input your password here',
              Icons.lock,
            ),
            DView.height(32),
            ElevatedButton(
              onPressed: () {
                // TODO: Add logic for account login

                // Move to the home screen after login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  AppColor.primary,
                ),
                minimumSize: MaterialStateProperty.all(
                  const Size(
                    double.infinity,
                    46,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 24,
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.openSans(
                    color: AppColor.light,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            DView.height(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Don’t have an account? click ',
                  style: GoogleFonts.openSans(
                    color: AppColor.sentenceSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Add navigation to the register page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Create Account',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: AppColor.primary,
                      fontWeight: FontWeight.w700,
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

  Widget _buildTextFieldWithLabelAndIcon(
    String label,
    String placeholder,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: AppColor.inputLabel,
          ),
        ),
        DView.height(6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColor.backgrounInput,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.backgrounInput,
                hoverColor: Colors.transparent,
                hintText: placeholder,
                suffixIcon: Icon(
                  icon,
                  size: 24,
                ),
                border: InputBorder.none,
                hintStyle: GoogleFonts.openSans(
                  color: AppColor.placeholder,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
