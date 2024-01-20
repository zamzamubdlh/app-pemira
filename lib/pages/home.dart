import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/config/app_session.dart';
import 'package:pemira_app/config/nav.dart';
import 'package:pemira_app/models/user_model.dart';
import 'package:pemira_app/pages/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  logout(BuildContext context) {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'You sure want to logout?',
      textNo: 'Cancel',
    ).then((yes) {
      if (yes ?? false) {
        AppSession.removeUser();
        AppSession.removeToken();
        Nav.replace(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return DView.loadingCircle();

        UserModel user = snapshot.data!;

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Welcome ${user.name}',
                            style: GoogleFonts.openSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 34),
                  Text(
                    'Main Menu',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColor.heading,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildMenuItem(
                    'Account',
                    Icons.account_circle_outlined,
                    () {
                      Navigator.pushNamed(context, '/auth/account');
                    },
                  ),
                  _buildMenuItem(
                    'Candidates',
                    Icons.person_2_outlined,
                    () {
                      Navigator.pushNamed(context, '/auth/candidates');
                    },
                  ),
                  _buildMenuItem(
                    'Vote',
                    Icons.how_to_vote_outlined,
                    () {
                      Navigator.pushNamed(context, '/auth/vote/menu');
                    },
                  ),
                  _buildMenuItem(
                    'Election Fraud',
                    Icons.error_outline_outlined,
                    () {
                      Navigator.pushNamed(context, '/auth/election_fraud');
                    },
                  ),
                  InkWell(
                    onTap: () => logout(context),
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
                            'Logout',
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColor.heading,
                            ),
                          ),
                          const Icon(
                            Icons.logout_outlined,
                            color: AppColor.heading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
