import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/widgets/i_field.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/utils/validate.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/auth/presentation/views/enter_phone_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.phoneNumberController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            IField(
              hintText: 'phoneNumber'.tr(),
              controller: widget.phoneNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enterPhoneNumber'.tr();
                }
                if (!Validate.phoneValidate(value)) {
                  return 'enterPhoneNumber'.tr();
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              overrideValidator: true,
            ),
            const SizedBox(height: 25),
            IField(
              hintText: 'password'.tr(),
              controller: widget.passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enterPassword'.tr();
                }
                return null;
              },
              obscureText: obscurePassword,
              overrideValidator: true,
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    AppNavigator.pauseAndPushScreen(
                      context: context,
                      routname: EnterPhoneScreen.routeName,
                      delayTime: 0,
                    );
                  },
                  child: BaseText(
                    value: 'forgotPassword'.tr(),
                    color: Colours.highStaticColour,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              child: RoundedButton(
                label: BaseText(
                  value: 'signIn'.tr(),
                  color: Colors.white,
                  weight: FontWeight.w500,
                  size: 22,
                ),
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          SignInEvent(
                            phoneNumber:
                                widget.phoneNumberController.text.trim(),
                            password: widget.passwordController.text.trim(),
                          ),
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
