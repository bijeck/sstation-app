import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/app/providers/hive_provider.dart';
import 'package:sstation/core/common/app/providers/user_provider.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sstation/features/dashboard/presentation/views/dashboard_screen.dart';
import 'package:sstation/features/profile/presentation/views/change_password_screen.dart';
import 'package:sstation/features/auth/presentation/views/sign_in_screen.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
import 'package:sstation/features/profile/presentation/views/update_profile_screen.dart';
import 'package:sstation/features/profile/presentation/widgets/option_button.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
  });

  static const routeName = 'profile';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'personalInformationTitle'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (_, userProvider, __) {
          if (userProvider.user != null) {
            LocalUser user = userProvider.user!;
            return AppBackground(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: context.width,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: CircleAvatar(
                              backgroundImage: user.avatarUrl.isNotEmpty
                                  ? NetworkImage(user.avatarUrl)
                                  : const AssetImage(MediaRes.noAvatar)
                                      as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BaseText(value: 'fullName'.tr()),
                              BaseText(
                                value: user.fullName,
                                color: Colors.black,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BaseText(value: 'phoneNumber'.tr()),
                              BaseText(
                                value: user.phoneNumber,
                                color: Colors.black,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BaseText(value: 'email'.tr()),
                              BaseText(
                                value: user.email,
                                color: Colors.black,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BaseText(value: 'password'.tr()),
                              const BaseText(
                                value: '********',
                                color: Colors.black,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: context.width * 0.4,
                            child: RoundedButton(
                              radius: 10,
                              label: BaseText(
                                value: 'edit'.tr(),
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: () {
                                AppNavigator.pauseAndPushScreen(
                                  context: context,
                                  routname: UpdateProfileScreen.routeName,
                                  delayTime: 0,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    OptionButton(
                      title: BaseText(value: 'changePassword'.tr(), size: 15),
                      icon: const Icon(Icons.change_circle_outlined,
                          color: Colours.primaryTextColour),
                      onTap: () {
                        AppNavigator.pauseAndPushScreen(
                          context: context,
                          routname: ChangePasswordScreen.routeName,
                          delayTime: 0,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    OptionButton(
                      title: BaseText(value: 'language'.tr(), size: 15),
                      icon: const Icon(Icons.language,
                          color: Colours.primaryTextColour),
                      onTap: () async {},
                      leading: Switch(
                        // thumbIcon: thumbIcon,
                        value: HiveProvider.getLocale().languageCode == 'vi'
                            ? true
                            : false,
                        trackOutlineColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return Colors.grey.withOpacity(.7);
                        }),
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.white,

                        activeThumbImage: const AssetImage(MediaRes.vn),
                        inactiveThumbImage: const AssetImage(MediaRes.en),
                        onChanged: (bool value) {
                          AppDialog.showConfirm(
                              child: BaseText(
                                value: 'confirmChangeLanguage'.tr(),
                                maxLine: 2,
                                size: 17,
                                weight: FontWeight.w500,
                              ),
                              onCancel: () => AppDialog.closeDialog(),
                              onSuccess: () async {
                                await HiveProvider.setLocale(
                                        value ? 'vi' : 'en')
                                    .then(
                                  (value) async =>
                                      await context.setLocale(value).then(
                                            (value) => AppNavigator
                                                .pauseAndPushNewScreenWithoutBack(
                                              context: context,
                                              routname: Dashboard.routeName,
                                              delayTime: 0,
                                            ),
                                          ),
                                );
                              });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    OptionButton(
                      title: BaseText(value: 'logout'.tr(), size: 15),
                      icon: const Icon(Icons.logout,
                          color: Colours.primaryTextColour),
                      onTap: () async {
                        context.read<AuthBloc>().add(const SignOutEvent());
                        HiveProvider.clearToken(
                          () => AppNavigator.pauseAndPushNewScreenWithoutBack(
                            context: context,
                            routname: SignInScreen.routeName,
                            delayTime: 0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
