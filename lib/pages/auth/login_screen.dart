import 'dart:math';

import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:d_view/d_view.dart';
import 'package:pemira_app/config/app_assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemira_app/config/app_colors.dart';
import 'package:pemira_app/config/app_response.dart';
import 'package:pemira_app/config/app_session.dart';
import 'package:pemira_app/config/failure.dart';
import 'package:pemira_app/config/nav.dart';
import 'package:pemira_app/datasources/user_datasource.dart';
import 'package:pemira_app/pages/home.dart';
import 'package:pemira_app/providers/login_provider.dart';
import 'register_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final editEmail = TextEditingController();
  final editPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  execute() {
    bool validInput = formKey.currentState!.validate();
    if (!validInput) return;

    setLoginStatus(ref, 'Loading');

    UserDatasource.login(editEmail.text, editPassword.text).then((value) {
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

          setLoginStatus(ref, newStatus);
        },
        (result) {
          AppSession.setUser(result['user']);
          AppSession.setToken(result['token']);
          DInfo.toastSuccess('Login Success');

          setLoginStatus(ref, 'Login Success');
          Nav.replace(context, const HomeScreen());
        },
      );
    });
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
          child: Form(
            key: formKey,
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
                  editEmail,
                  'Email',
                  'Input your email here',
                  Icons.email,
                  false,
                ),
                DView.height(16),
                _buildTextFieldWithLabelAndIcon(
                  editPassword,
                  'Password',
                  'Input your password here',
                  Icons.lock,
                  true,
                ),
                DView.height(32),
                Column(
                  children: [
                    Consumer(
                      builder: (_, wiRef, __) {
                        String status = wiRef.watch(loginStatusProvider);

                        if (status == 'Loading') {
                          return DView.loadingCircle();
                        }
                        return ElevatedButton(
                          onPressed: () => execute(),
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
                              vertical: 0,
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
                        );
                      },
                    ),
                  ],
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
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
        ),
      ),
    );
  }

  Widget _buildTextFieldWithLabelAndIcon(
    TextEditingController controller,
    String label,
    String placeholder,
    IconData icon,
    bool isPassword,
  ) {
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
              controller: controller,
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
