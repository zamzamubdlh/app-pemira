import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/config/app_assets.dart';
import 'package:pemira_app/pages/auth/candidates/candidates_screen.dart';

class CandidatesProfileScreen extends StatelessWidget {
  const CandidatesProfileScreen({super.key});

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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CandidatesScreen(),
                          ),
                        );
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
                            'Candidates Profile',
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
                '1st Candidate',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: AppColor.heading,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Calon PresMa',
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF999999),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssets.profile,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoItem('Nama:', 'Dede Sunarwan'),
                      _buildInfoItem('Umur:', '25'),
                      _buildInfoItem('Program Studi:', 'Teknik Informatika'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 34),
              _buildInputItem(
                  'Penjelasan Singkat', 'Ini adalah penjelasan singkat saya'),
              _buildInputItem('Visi', 'Ini adalah visi saya'),
              _buildInputItem('Misi', 'Ini adalah misi saya'),
              _buildInputItem('Why', 'Ini alasan kenapa harus memeilih saya'),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CandidatesScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Next Candidate',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColor.light,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColor.inputLabel,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0XFFCCCCCC),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildInputItem(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColor.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              label,
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColor.heading,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColor.backgrounInput,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: placeholder,
                  border: InputBorder.none,
                ),
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF989595),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
