import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/auth/presentation/views/sign_up_screen.dart';
import 'package:sstation/features/auth/presentation/widgets/otp_verification.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
    required this.phoneNumber,
    this.routeTo,
  });
  final String phoneNumber;
  final String? routeTo;
  static const routeName = 'verifying';

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  OtpFieldController otpController = OtpFieldController();
  String _otp = '';
  void _update(String otp) {
    setState(() => _otp = otp);
  }

  @override
  void dispose() {
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is VerifiedPhoneNumber) {
            // VerifiedPhoneNumber when otp is matched
            AppDialog.closeDialog();
            AppNavigator.pauseAndPushScreen(
              context: context,
              routname: widget.routeTo ?? SignUpScreen.routeName,
              delayTime: 0,
              arguments: {
                'accessToken': state.tempToken,
                'phoneNumber': widget.phoneNumber,
              },
            );
          } else if (state is VerifyError) {
            // VerifyError when otp is not matched
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
          } else if (state is AuthLoading) {
            // Show loading dialog
            AppDialog.showLoadingDialog(message: 'verifying'.tr());
          }
        },
        builder: (context, state) {
          return AppBackground(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Center(
                        child: Lottie.asset(MediaRes.verificationWaiting),
                      ),
                    ),
                    BaseText(
                      value: 'verification'.tr(),
                      size: 25,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 20),
                    BaseText(
                      value: 'enterCode'.tr(),
                      size: 20,
                      color: Colors.black,
                    ),
                    BaseText(
                      value: '${'sentAt'.tr()} ${widget.phoneNumber}',
                      size: 20,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    OTPVerification(
                        otpController: otpController, onChanged: _update),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 150,
                      child: RoundedButton(
                        onPressed: () {
                          if (_otp.length == 6) {
                            context.read<AuthBloc>().add(
                                  SentOTPVerificationEvent(
                                    phoneNumber: widget.phoneNumber,
                                    otp: _otp,
                                  ),
                                );
                          } else {
                            AppDialog.showMessageDialog(
                                Text('enterValidCode'.tr()));
                          }
                        },
                        label: BaseText(
                          value: 'confirm'.tr(),
                          color: Colors.white,
                          weight: FontWeight.w500,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
