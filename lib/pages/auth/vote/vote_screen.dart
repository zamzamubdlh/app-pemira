import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:pemira_app/datasources/vote_datasource.dart';
import 'package:pemira_app/models/candidate_model.dart';
import 'package:pemira_app/pages/auth/vote/vote_menu_screen.dart';
import 'package:pemira_app/providers/candidate_provider.dart';

class VoteScreen extends ConsumerStatefulWidget {
  const VoteScreen({super.key});

  @override
  ConsumerState<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends ConsumerState<VoteScreen> {
  Map<String, bool> candidates = {};

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController candidateIdController = TextEditingController();

  getCandidateThisYear() {
    VoteDatasource.getCandidateThisYear().then((value) {
      String newStatus = '';

      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              newStatus = 'Server Error';
              break;
            case NotFoundFailure:
              DMethod.printTitle('NOT FOUND FAILURE', failure.message.toString());
              newStatus = 'Error Not Found';
              break;
            case ForbiddenFailure:
              DMethod.printTitle('FORBIDDEN FAILURE', failure.message.toString());
              newStatus = 'You Don\'t Have Access';
              break;
            case BadRequestFailure:
              newStatus = 'Bad Request';
              break;
            case InvalidInputFailure:
              newStatus = 'Invalid Input';
              AppResponse.invalidInput(context, failure.message ?? '{}');
              break;
            case UnauthorisedFailure:
              DMethod.printTitle('UNAUTHORIZED FAILURE', failure.message.toString());
              newStatus = 'Unathorized';
              DInfo.toastError(jsonDecode(failure.message.toString())['message']);
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
          DInfo.toastSuccess('Get List Candidate Success');
          setCandidateStatus(ref, 'Get List Candidate Success');

          List data = result['data'];
          List<CandidateModel> candiates = data.map((e) => CandidateModel.fromJson(e)).toList();

          ref.read(candidateThisYearListProvider.notifier).setData(candiates);
        },
      );
    });
  }

  execute(candidateId) {
    VoteDatasource.vote(
      candidateId.toString(),
    ).then((value) {
      String newStatus = '';

      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              newStatus = 'Server Error';
              break;
            case NotFoundFailure:
              DMethod.printTitle('NOT FOUND FAILURE', failure.message.toString());
              newStatus = 'Error Not Found';
              break;
            case ForbiddenFailure:
              DMethod.printTitle('FORBIDDEN FAILURE', failure.message.toString());
              newStatus = 'You Don\'t Have Access';
              break;
            case BadRequestFailure:
              DInfo.toastError(jsonDecode(failure.message.toString())['message']);
              newStatus = 'Bad Request';
              break;
            case InvalidInputFailure:
              newStatus = 'Invalid Input';
              AppResponse.invalidInput(context, failure.message ?? '{}');
              break;
            case UnauthorisedFailure:
              DMethod.printTitle('UNAUTHORIZED FAILURE', failure.message.toString());
              newStatus = 'Unathorized';
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
          DInfo.toastSuccess('Vote Candidate Successfully');
          setCandidateStatus(ref, 'Vote Candidate Successfully');
        },
      );
    });
  }

  refresh() {
    getCandidateThisYear();
  }

  @override
  void initState() {
    refresh();

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
                            builder: (context) => const VoteMenuScreen(),
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
                            'Vote',
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
                'Vote',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: AppColor.heading,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Please vote your candidate',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 19),
              Consumer(
                builder: (_, wiRef, __) {
                  List<CandidateModel> candidates = wiRef.watch(candidateThisYearListProvider);

                  return Column(
                    children: candidates.map((candidate) {
                      return _buildMenuItem(candidate.id, candidate.name);
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              int? selectedCandidateId =
                  candidates.entries.firstWhere((entry) => entry.value, orElse: () => const MapEntry<String, bool>('null', false)).key != 'null'
                      ? int.tryParse(candidates.entries.firstWhere((entry) => entry.value).key)
                      : null;

              if (selectedCandidateId != null) {
                execute(selectedCandidateId);
              } else {
                DInfo.toastError('Please select a candidate before voting!');
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              'Vote',
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColor.light,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(int candidateId, String candidateName) {
    final String candidateKey = candidateId.toString();
    final isChecked = candidates[candidateKey] ?? false;

    return FormField<bool>(
      initialValue: isChecked,
      builder: (FormFieldState<bool> field) {
        return InkWell(
          onTap: () {
            setState(() {
              candidates.forEach((key, value) {
                candidates[key] = false;
              });
              candidates[candidateKey] = !isChecked;
              field.didChange(!isChecked);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        visualDensity: VisualDensity.compact,
                        checkColor: AppColor.light,
                        activeColor: AppColor.primary,
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            candidates.forEach((key, value) {
                              candidates[key] = false;
                            });
                            candidates[candidateName] = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      candidateName,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColor.heading,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
