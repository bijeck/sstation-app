// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/auth/presentation/views/sign_in_screen.dart';
import 'package:sstation/features/auth/presentation/widgets/password_input.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({
    super.key,
    required this.phoneNumber,
    required this.token,
  });
  final String phoneNumber;
  final String token;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static const routeName = 'reset-password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: BaseText(
          value: 'cancel'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordReset) {
            AppDialog.closeDialog();
            AppDialog.showMessageDialog(
              AppDialog.sucessMessage('resetPasswordSuccess'.tr()),
            );
            AppNavigator.pauseAndPushScreen(
              context: context,
              routname: SignInScreen.routeName,
              delayTime: 1,
            );
          } else if (state is VerifyError) {
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
            AppNavigator.pauseAndPushNewScreenWithoutBack(
              context: context,
              routname: SignInScreen.routeName,
              delayTime: 1,
            );
          } else if (state is ExpiredToken) {
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
            AppNavigator.pauseAndPushNewScreenWithoutBack(
              context: context,
              routname: SignInScreen.routeName,
              delayTime: 1,
            );
          } else if (state is AuthLoading) {
            AppDialog.showLoadingDialog();
          }
        },
        child: AppBackground(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                BaseText(
                  value: 'newPassword'.tr(),
                  size: 20,
                  weight: FontWeight.w500,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colours.backgroundColour,
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      image: AssetImage(MediaRes.enterPhone),
                    ),
                  ),
                  width: double.infinity,
                  height: 250,
                ),
                Form(
                  key: formKey,
                  child: PasswordInput(
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  child: RoundedButton(
                    label: BaseText(
                      value: 'resetPassword'.tr(),
                      color: Colors.white,
                      weight: FontWeight.w500,
                      size: 22,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                      context.read<AuthBloc>().add(
                            ResetPasswordEvent(
                              token: token,
                              newPassword: passwordController.text,
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
  }
}
