// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sstation/core/res/colours.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:sstation/features/auth/presentation/widgets/register_form.dart';

class SignSwitchTab extends StatefulWidget {
  const SignSwitchTab({
    super.key,
    required this.phoneNumberController,
    required this.passwordController,
    required this.signInformKey,
    required this.registerformKey,
  });

  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> signInformKey;
  final GlobalKey<FormState> registerformKey;

  @override
  State<SignSwitchTab> createState() => _SignSwitchTabState();
}

class _SignSwitchTabState extends State<SignSwitchTab> {
  int indexSelected = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelPadding: const EdgeInsets.only(left: 20, right: 20),
            automaticIndicatorColorAdjustment: true,
            tabAlignment: TabAlignment.fill,
            labelColor: Colours.primaryTextColour,
            unselectedLabelColor: Colours.highStaticColour,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            onTap: (index) {
              setState(() {
                indexSelected = index;
              });
            },
            tabs: [
              Tab(
                icon: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'signIn'.tr(),
                    style: TextStyle(
                      fontSize: indexSelected == 0 ? 25 : 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'register'.tr(),
                    style: TextStyle(
                      fontSize: indexSelected == 1 ? 25 : 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              children: [
                SignInForm(
                  phoneNumberController: widget.phoneNumberController,
                  passwordController: widget.passwordController,
                  formKey: widget.signInformKey,
                ),
                RegisterForm(
                  buttonTile: 'register'.tr(),
                  formKey: widget.registerformKey,
                  phoneNumberController: widget.phoneNumberController,
                  action: () {
                    context.read<AuthBloc>().add(
                          VerifyPhoneNumberEvent(
                            phoneNumber:
                                widget.phoneNumberController.text.trim(),
                          ),
                        );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
