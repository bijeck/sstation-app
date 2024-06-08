import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/i_field.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/core/utils/validate.dart';
import 'package:sstation/features/auth/presentation/views/sign_in_screen.dart';
import 'package:sstation/features/profile/presentation/bloc/user_profile_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String routeName = 'change-password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'updatePasswordTitle'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
      ),
      body: AppBackground(
        child: BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
            if (state is ChangedPassword) {
              var tokenBox = Hive.box('token');
              tokenBox.clear().then((_) {
                Timer(
                  const Duration(seconds: 2),
                  () {
                    AppDialog.showMessageDialog(
                      AppDialog.sucessMessage(
                          'passwordUpdatedNotification'.tr()),
                    );

                    AppNavigator.pauseAndPushNewScreenWithoutBack(
                      context: context,
                      routname: SignInScreen.routeName,
                      delayTime: 1,
                    );
                  },
                );
              });
            }
            if (state is UserProfileError) {
              AppDialog.showMessageDialog(
                  AppDialog.errorMessage(state.message));
            }
            if (state is UserProfileLoading) {
              AppDialog.showLoadingDialog();
            }
          },
          child: Form(
            key: formKey,
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Lottie.asset(MediaRes.writeInput),
                    ),
                  ),
                  const SizedBox(height: 25),
                  IField(
                    overrideValidator: true,
                    hintText: 'currentPassword'.tr(),
                    controller: oldPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enterPassword'.tr();
                      }
                      if (!Validate.passwordValidate(value)) {
                        return 'passwordValidate'.tr();
                      }
                      return null;
                    },
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        obscurePassword = !obscurePassword;
                      }),
                      icon: Icon(
                        obscurePassword ? IconlyLight.show : IconlyLight.hide,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  IField(
                    overrideValidator: true,
                    hintText: 'newPassword'.tr(),
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enterPassword'.tr();
                      }
                      if (!Validate.passwordValidate(value)) {
                        return 'passwordValidate'.tr();
                      }
                      return null;
                    },
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        obscurePassword = !obscurePassword;
                      }),
                      icon: Icon(
                        obscurePassword ? IconlyLight.show : IconlyLight.hide,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  IField(
                    hintText: 'confirmPassword'.tr(),
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null ||
                          value.compareTo(newPasswordController.text.trim()) !=
                              0) {
                        return 'confirmPasswordValidate'.tr();
                      }
                      return null;
                    },
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        obscurePassword = !obscurePassword;
                      }),
                      icon: Icon(
                        obscurePassword ? IconlyLight.show : IconlyLight.hide,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    child: RoundedButton(
                      label: BaseText(
                        value: 'update'.tr(),
                        color: Colors.white,
                        weight: FontWeight.w500,
                        size: 22,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppDialog.showConfirm(
                            child: const BaseText(
                              value: 'Confirm change?',
                              size: 20,
                              weight: FontWeight.w500,
                              color: Colours.primaryTextColour,
                            ),
                            onCancel: () => SmartDialog.dismiss(),
                            onSuccess: () {
                              context.read<UserProfileBloc>().add(
                                    ChangePasswordEvent(
                                      oldPassword:
                                          oldPasswordController.text.trim(),
                                      newPassword:
                                          newPasswordController.text.trim(),
                                    ),
                                  );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
