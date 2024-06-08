import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/auth/presentation/views/sign_in_screen.dart';
import 'package:sstation/features/auth/presentation/widgets/fill_information_form.dart';
import 'package:sstation/features/dashboard/presentation/views/dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.phoneNumber,
    required this.token,
  });
  final String phoneNumber;
  final String token;
  static const routeName = 'sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: BaseText(
          value: 'cancel'.tr(),
          weight: FontWeight.w600,
          size: 20,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            // AuthError when can not create account
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
          } else if (state is SignedUp) {
            // SignedUp then sent event to signin
            context.read<AuthBloc>().add(
                  SignInEvent(
                    phoneNumber: widget.phoneNumber,
                    password: passwordController.text.trim(),
                  ),
                );
          } else if (state is SignedIn) {
            // SignedIn and move to Dashboard
            AppDialog.showMessageDialog(
                AppDialog.sucessMessage('signUpSuccess'.tr()));
            AppNavigator.pauseAndPushNewScreenWithoutBack(
              context: context,
              routname: Dashboard.routeName,
              delayTime: 4,
            );
          } else if (state is AuthLoading) {
            // Show loading dialog
            AppDialog.showLoadingDialog(message: 'signingUp'.tr());
          } else if (state is ExpiredToken) {
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
            AppNavigator.pauseAndPushNewScreenWithoutBack(
              context: context,
              routname: SignInScreen.routeName,
              delayTime: 1,
            );
          }
        },
        builder: (context, state) {
          return AppBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 50),
                    child: BaseText(
                      value: 'completeProfile'.tr(),
                      size: 25,
                      weight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: Lottie.asset(MediaRes.writeInput),
                    ),
                  ),
                  FillInformationForm(
                    phoneNumber: widget.phoneNumber,
                    token: widget.token,
                    fullNameController: fullNameController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    formKey: formKey,
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
