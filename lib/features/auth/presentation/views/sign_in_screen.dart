import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/auth/presentation/views/verification_screen.dart';
import 'package:sstation/features/auth/presentation/widgets/sign_switch_tab.dart';
import 'package:sstation/features/dashboard/presentation/views/dashboard_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = 'sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final signInformKey = GlobalKey<FormState>();
  final registerformKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) async {
          if (state is AuthError) {
            // AuthError when the user is not found
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
          } else if (state is VerifyError) {
            // VerifyError when the phone number is not valid
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
          } else if (state is SignedIn) {
            // SignedIn and move to Dashboard
            AppDialog.showMessageDialog(
                AppDialog.sucessMessage('wellcomeBack'.tr()));
            AppNavigator.pauseAndPushNewScreenWithoutBack(
                context: context, routname: Dashboard.routeName, delayTime: 2);
          } else if (state is AuthLoading) {
            // Shown Loading Dialog
            // SmartDialog.showLoading();
            AppDialog.showLoadingDialog(message: 'signing'.tr());
          } else if (state is Verifying) {
            // Phone number is valid and move to Verification Screen
            AppNavigator.pauseAndPushScreen(
              context: context,
              routname: VerificationScreen.routeName,
              delayTime: 0,
              arguments: {
                'phoneNumber': phoneNumberController.text.trim(),
              },
            );
          }
        },
        builder: (context, state) {
          return AppBackground(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/logo/logo_zoom.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const BaseText(
                          value: 'SStation',
                          weight: FontWeight.w700,
                          size: 30,
                          color: Colours.primaryColour,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const BaseText(
                    value: 'On-the-Go Packages,',
                    weight: FontWeight.w500,
                    size: 24,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BaseText(
                        value: 'Your Terms!',
                        weight: FontWeight.w500,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    height: 400,
                    child: SignSwitchTab(
                      passwordController: passwordController,
                      phoneNumberController: phoneNumberController,
                      signInformKey: signInformKey,
                      registerformKey: registerformKey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
