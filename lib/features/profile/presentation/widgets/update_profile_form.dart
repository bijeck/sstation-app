import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/i_field.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.formKey,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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
            hintText: 'email'.tr(),
            controller: widget.emailController,
            validator: (value) {
              if (value!.isNotEmpty) {
                if (!EmailValidator.validate(value)) {
                  return 'enterEmail'.tr();
                }
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
