import 'package:flutter/material.dart';
import 'package:pemira_app/pages/auth/account/account_about.dart';
import 'package:pemira_app/pages/auth/account/account_previous_vote_screen.dart';
import 'package:pemira_app/pages/auth/account/account_screen.dart';
import 'package:pemira_app/pages/auth/account/account_setting_screen.dart';
import 'package:pemira_app/pages/auth/candidates/candidates_debates_screen.dart';
import 'package:pemira_app/pages/auth/candidates/candidates_screen.dart';
import 'package:pemira_app/pages/auth/vote/temporary_vote_acquisition_screen.dart';
import 'package:pemira_app/pages/auth/vote/vote_menu_screen.dart';
import 'config/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/splash/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: AppColor.primary,
          secondary: Colors.greenAccent[400]!,
        ),
        textTheme: GoogleFonts.openSansTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(AppColor.primary),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
            ),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/auth/account': (context) => const AccountScreen(),
        '/auth/account/setting': (context) => const AccountSettingScreen(),
        '/auth/account/previous_vote': (context) =>
            const AccountPreviousVoteScreen(),
        '/auth/account/about': (context) => const AccountAboutScreen(),
        '/auth/candidates': (context) => const CandidatesScreen(),
        '/auth/candidates/debates_presentation': (context) =>
            const CandidatesDebatesScreen(),
        '/auth/vote/menu': (context) => const VoteMenuScreen(),
        '/auth/vote': (context) => const VoteMenuScreen(),
        '/auth/vote/temporary_vote_acquisition': (context) =>
            const TemporaryVoteAcquisitionScreen(),
      },
    );
  }
}
