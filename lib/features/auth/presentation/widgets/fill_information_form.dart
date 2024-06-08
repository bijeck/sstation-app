import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sstation/core/common/widgets/i_field.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/utils/validate.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';

class FillInformationForm extends StatefulWidget {
  const FillInformationForm({
    required this.phoneNumber,
    required this.token,
    required this.fullNameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    super.key,
  });

  final String phoneNumber;
  final String token;
  final TextEditingController fullNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<FillInformationForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<FillInformationForm> {
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
              overrideValidator: true,
              hintText: 'fullName'.tr(),
              controller: widget.fullNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enterFullName'.tr();
                }
                return null;
              },
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 25),
            IField(
              overrideValidator: true,
              hintText: 'password'.tr(),
              controller: widget.passwordController,
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
              hintText: 'confirmPassword',
              controller: widget.confirmPasswordController,
              validator: (value) {
                if (value == null ||
                    value.compareTo(widget.passwordController.text.trim()) !=
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
                label:  BaseText(
                  value: 'finish'.tr(),
                  color: Colors.white,
                  weight: FontWeight.w500,
                  size: 22,
                ),
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          SignUpEvent(
                            phoneNumber: widget.phoneNumber,
                            password: widget.passwordController.text.trim(),
                            name: widget.fullNameController.text.trim(),
                            token: widget.token,
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
