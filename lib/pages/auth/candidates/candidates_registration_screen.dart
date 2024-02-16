import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/app_session.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:pemira_app/datasources/candidate_datasource.dart';
import 'package:pemira_app/models/user_model.dart';
import 'package:pemira_app/pages/auth/candidates/candidates_screen.dart';
import 'package:pemira_app/providers/candidate_provider.dart';

class CandidatesRegistrationScreen extends ConsumerStatefulWidget {
  const CandidatesRegistrationScreen({super.key});

  @override
  ConsumerState<CandidatesRegistrationScreen> createState() => _CandidatesRegistrationScreenState();
}

class _CandidatesRegistrationScreenState extends ConsumerState<CandidatesRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late FilePickerResult? _pickedFileResult;

  TextEditingController programStudyController = TextEditingController();
  TextEditingController visionController = TextEditingController();
  TextEditingController missionController = TextEditingController();
  TextEditingController shortDescController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  execute(age, name) {
    List<int> imageBytes = File(_pickedFileResult?.files.single.path ?? '').readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    CandidateDatasource.registerCandidate(
      age.toString(),
      programStudyController.text,
      shortDescController.text,
      visionController.text,
      missionController.text,
      base64Image,
      reasonController.text,
      name,
    ).then((value) {
      value.fold(
        (failure) {
          String newStatus = '';

          switch (failure.runtimeType) {
            case ServerFailure:
              setRegisterCandidateStatus(ref, 'Server Error');
              break;
            case NotFoundFailure:
              setRegisterCandidateStatus(ref, 'Error Not Found');
              break;
            case ForbiddenFailure:
              setRegisterCandidateStatus(ref, 'You don\'t have access');
              break;
            case BadRequestFailure:
              DInfo.toastError(jsonDecode(failure.message.toString())['message']);
              setRegisterCandidateStatus(ref, 'Bad Request');
              break;
            case InvalidInputFailure:
              var newStatus = 'Invalid Input';
              AppResponse.invalidInput(context, failure.message ?? '{}');
              setRegisterCandidateStatus(ref, newStatus);
              break;
            case UnauthorisedFailure:
              newStatus = 'Unauthorized';
              DInfo.toastError(newStatus);
              break;
            default:
              newStatus = failure.message ?? '-';
              setRegisterCandidateStatus(ref, newStatus);
              DInfo.toastError(newStatus);
              break;
          }
        },
        (result) {
          DInfo.toastSuccess('Candidate successfully registered');
          setRegisterCandidateStatus(ref, 'Success');
        },
      );
    });
  }

  @override
  void initState() {
    _pickedFileResult = null;

    super.initState();
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
                                'Candidates Registration',
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
                  Form(
                    key: _formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg'],
                            );

                            if (result != null && result.files.isNotEmpty) {
                              setState(() {
                                _pickedFileResult = result;
                                photoController.text = result.files.single.path!;
                              });
                            } else {
                              DInfo.toastError('Please select an image');
                              return;
                            }
                          },
                          child: const Text('Upload Photo'),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoItem('Nama:', user.name),
                            _buildInfoItem('Umur:', user.age?.toString() ?? "-"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 34),
                  _buildInputItem(
                    'Program Studi',
                    'eg: Teknik Informatika',
                    programStudyController,
                  ),
                  _buildInputItem(
                    'Penjelasan Singkat',
                    'Tuliskan penjelasan singkat di sini',
                    shortDescController,
                  ),
                  _buildInputItem(
                    'Visi',
                    'Tuliskan visi di sini',
                    visionController,
                  ),
                  _buildInputItem(
                    'Misi',
                    'Tuliskan misi di sini',
                    missionController,
                  ),
                  _buildInputItem(
                    'Why',
                    'Tuliskan mengapa Anda memilih kandidat ini',
                    reasonController,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_pickedFileResult == null || _pickedFileResult!.files.isEmpty) {
                          DInfo.toastError('Please select an image');
                          return;
                        } else {
                          if (_formKey.currentState!.validate()) {
                            execute(user.age, user.name);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Save',
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
      },
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

  Widget _buildInputItem(String label, String placeholder, TextEditingController controller) {
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
                controller: controller,
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
