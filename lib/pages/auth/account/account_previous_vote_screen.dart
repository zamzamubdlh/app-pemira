// ignore_for_file: library_private_types_in_public_api

import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:pemira_app/datasources/candidate_datasource.dart';
import 'package:pemira_app/models/candidate_model.dart';
import 'package:pemira_app/pages/auth/account/account_screen.dart';
import 'package:pemira_app/providers/candidate_provider.dart';

class AccountPreviousVoteScreen extends ConsumerStatefulWidget {
  const AccountPreviousVoteScreen({Key? key}) : super(key: key);

  @override
  _AccountPreviousVoteScreenState createState() => _AccountPreviousVoteScreenState();
}

class _AccountPreviousVoteScreenState extends ConsumerState<AccountPreviousVoteScreen> {
  bool isExpanded = false;

  getPreviousVote() {
    setCandidateStatus(ref, 'Loading');

    CandidateDatasource.listPreviousVote().then((value) {
      String newStatus = '';

      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              DMethod.printTitle('SERVER FAILURE', failure.message.toString());
              newStatus = 'Server Error';
              DInfo.toastError(newStatus);
              break;
            case NotFoundFailure:
              DMethod.printTitle('NOT FOUND FAILURE', failure.message.toString());
              newStatus = 'Error Not Found';
              DInfo.toastError(newStatus);
              break;
            case ForbiddenFailure:
              DMethod.printTitle('FORBIDDEN FAILURE', failure.message.toString());
              newStatus = 'You Don\'t Have Access';
              DInfo.toastError(newStatus);
              break;
            case BadRequestFailure:
              DMethod.printTitle('BAD REQUEST FAILURE', failure.message.toString());
              newStatus = 'Bad Request';
              DInfo.toastError(newStatus);
              break;
            case InvalidInputFailure:
              DMethod.printTitle('INVALID FAILURE', failure.message.toString());
              newStatus = 'Invalid Input';
              AppResponse.invalidInput(context, failure.message ?? '{}');
              break;
            case UnauthorisedFailure:
              DMethod.printTitle('UNAUTHORIZED FAILURE', failure.message.toString());
              newStatus = 'Login Failed';
              DInfo.toastError(newStatus);
              break;
            default:
              DMethod.printTitle('DEFAULT FAILURE', failure.message.toString());
              newStatus = 'Request Error';
              DInfo.toastError(newStatus);
              newStatus = failure.message ?? '-';
              break;
          }

          setCandidateStatus(ref, newStatus);
        },
        (result) {
          DInfo.toastSuccess('Get List Previous Vote Success');
          setCandidateStatus(ref, 'Get List Previous Vote Success');

          List data = result['data'];
          List<CandidateModel> previousVotes = data.map((e) => CandidateModel.fromJson(e)).toList();

          ref.read(previousVoteListProvider.notifier).setData(previousVotes);
        },
      );
    });
  }

  refresh() {
    getPreviousVote();
  }

  @override
  void initState() {
    Future(() {
      refresh();
    });

    super.initState();
  }

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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountScreen(),
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
            const SizedBox(height: 18),
            Consumer(
              builder: (_, wiRef, __) {
                List<CandidateModel> candidates = wiRef.watch(previousVoteListProvider);

                return Column(children: [
                  if (isExpanded)
                    ...candidates.map((candidate) {
                      return _buildMenuItem('${candidate.year} - ${candidate.candidateName}');
                    }).toList(),
                ]);
              },
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
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
