// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';

class AccountPreviousVoteScreen extends StatefulWidget {
  const AccountPreviousVoteScreen({Key? key}) : super(key: key);

  @override
  _AccountPreviousVoteScreenState createState() =>
      _AccountPreviousVoteScreenState();
}

class _AccountPreviousVoteScreenState extends State<AccountPreviousVoteScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
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
                          'Previous Vote',
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
              'Previous Vote',
              style: GoogleFonts.playfairDisplay(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: AppColor.heading,
              ),
            ),
            const SizedBox(height: 32),
            _buildCollapsibleMenuItem(),
            const SizedBox(height: 38),
            if (isExpanded)
              Column(
                children: [
                  _buildMenuItem('2022 - Name'),
                  _buildMenuItem('2021 - Name'),
                  _buildMenuItem('2020 - Name'),
                  _buildMenuItem('2019 - Name'),
                  _buildMenuItem('2018 - Name'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsibleMenuItem() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilihan Saya Sebelumnya',
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.heading,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String text) {
    return Column(
      children: [
        Container(
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
            ],
          ),
        ),
      ],
    );
  }
}
