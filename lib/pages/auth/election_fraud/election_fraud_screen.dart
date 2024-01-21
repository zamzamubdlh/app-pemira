import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/app_session.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:pemira_app/datasources/election_fraud_datasource.dart';
import 'package:pemira_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pemira_app/pages/home.dart';
import 'package:pemira_app/providers/election_fraud_provider.dart';

class ElectionFraudScreen extends ConsumerStatefulWidget {
  const ElectionFraudScreen({super.key});

  @override
  ConsumerState<ElectionFraudScreen> createState() => _ElectionFraudScreenState();
}

class _ElectionFraudScreenState extends ConsumerState<ElectionFraudScreen> {
  final editDate = TextEditingController();
  final editDescription = TextEditingController();
  final editPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  execute(user) {
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;

    setReportFraudStatus(ref, 'Loading');

    ElectionFraudDatasource.reportFraud(
      user.token,
      user.id,
      editDate.text,
      editDescription.text,
      editPassword.text,
    ).then((value) {
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
              newStatus = 'Unathorized';
              DInfo.toastError(newStatus);
              break;
            default:
              DMethod.printTitle('DEFAULT FAILURE', failure.message.toString());
              newStatus = 'Request Error';
              DInfo.toastError(newStatus);
              newStatus = failure.message ?? '-';
              break;
          }

          setReportFraudStatus(ref, newStatus);
        },
        (result) {
          DInfo.toastSuccess('Report Fraud Success');

          setReportFraudStatus(ref, 'Report Fraud Success');
        },
      );
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
              child: Form(
                key: formKey,
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
                                  builder: (context) => const HomeScreen(),
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
                                  'Election Fraud',
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
                      'Election Fraud',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: AppColor.heading,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Melaporkan kecurangan pemilihan',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 68),
                    buildInputItem(
                      'Password',
                      'Input Password',
                      editPassword,
                      true,
                    ),
                    buildInputItem(
                      'Tanggal Kejadian',
                      'yyyy-mm-dd',
                      editDate,
                      false,
                    ),
                    buildInputItem(
                      'Input Report',
                      'Reporting Election Fraud',
                      editDescription,
                      false,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Consumer(
                        builder: (_, wiRef, __) {
                          String status = wiRef.watch(reportFraudStatus);

                          if (status == 'Loading') {
                            return DView.loadingCircle();
                          }

                          return ElevatedButton(
                            onPressed: () => execute(user),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'Submit Report',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.light,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildInputItem(
    String label,
    String placeholder,
    TextEditingController controller,
    bool isPassword,
  ) {
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
                obscureText: isPassword,
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
