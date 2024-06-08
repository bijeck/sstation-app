import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/auth/presentation/views/reset_password_screen.dart';
import 'package:sstation/features/auth/presentation/views/verification_screen.dart';
import 'package:sstation/features/auth/presentation/widgets/register_form.dart';

class EnterPhoneScreen extends StatelessWidget {
  EnterPhoneScreen({super.key});

  static const routeName = 'enter-phone';

  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          if (state is AuthError) {
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
          } else if (state is VerifyError) {
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
          } else if (state is AuthLoading) {
            AppDialog.showLoadingDialog();
          } else if (state is Verifying) {
            AppNavigator.pauseAndPushScreen(
              context: context,
              routname: VerificationScreen.routeName,
              delayTime: 0,
              arguments: {
                'phoneNumber': phoneNumberController.text.trim(),
                'routeTo': ResetPasswordScreen.routeName,
              },
            );
          }
        },
        child: AppBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              BaseText(
                value: 'requestPhoneNumber'.tr(),
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
              RegisterForm(
                buttonTile: 'continue'.tr(),
                phoneNumberController: phoneNumberController,
                formKey: formKey,
                action: () {
                  context.read<AuthBloc>().add(
                        VerifyPhoneNumberEvent(
                          phoneNumber: phoneNumberController.text.trim(),
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
