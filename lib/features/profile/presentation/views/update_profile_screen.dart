import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sstation/core/common/app/dialog.dart';
import 'package:sstation/core/common/app/navigator.dart';
import 'package:sstation/core/common/app/providers/user_provider.dart';
import 'package:sstation/core/common/widgets/app_background.dart';
import 'package:sstation/core/common/widgets/rounded_button.dart';
import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/core/services/image_picker/pick_image.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
import 'package:sstation/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:sstation/features/profile/presentation/views/user_profile_screen.dart';
import 'package:sstation/features/profile/presentation/widgets/update_profile_form.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const routeName = 'update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();
  File? image;
  late LocalUser user;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    user = context.read<UserProvider>().user!;
    fullNameController = TextEditingController(text: user.fullName);
    emailController = TextEditingController(text: user.email);
    super.initState();
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          const SizedBox(height: 12.0),
                          BaseText(
                            value: 'gallery'.tr(),
                          )
                        ],
                      ),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: SizedBox(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            const SizedBox(height: 12.0),
                            BaseText(
                              value: 'camera'.tr(),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  void pickImage(ImageSource source) async {
    final pickedimage = await PickImage.pickImage(source);
    setState(() {
      image = pickedimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: BaseText(
          value: 'updateProfileTitle'.tr(),
          weight: FontWeight.w600,
          size: 25,
        ),
      ),
      body: BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            AppDialog.showMessageDialog(AppDialog.errorMessage(state.message));
          } else if (state is UpdatedUserProfile) {
            context.read<UserProfileBloc>().add(const InitUserProfileEvent());
          } else if (state is UserProfileLoaded) {
            AppDialog.showMessageDialog(
                AppDialog.sucessMessage('profileUpdated'.tr()));
            context.userProvider.initUser(state.user);
            AppNavigator.pauseAndPushNewScreenWithoutBack(
              context: context,
              routname: UserProfileScreen.routeName,
              delayTime: 2,
            );
          } else if (state is UserProfileLoading) {
            AppDialog.showLoadingDialog(message: 'updatingProfile'.tr());
          }
        },
        child: AppBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: context.width,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: CircleAvatar(
                            backgroundImage: image != null
                                ? FileImage(image!)
                                : user.avatarUrl.isNotEmpty
                                    ? NetworkImage(user.avatarUrl)
                                    : const AssetImage(MediaRes.noAvatar)
                                        as ImageProvider,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          showImagePicker(context);
                        },
                        child: BaseText(
                          value: 'changeAvatar'.tr(),
                          color: Colors.blue,
                          size: 15,
                        ),
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
                      UpdateProfileForm(
                        fullNameController: fullNameController,
                        emailController: emailController,
                        formKey: formKey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: context.width * 0.3,
                      child: RoundedButton(
                        radius: 10,
                        buttonColour: Colours.notactiveButtonColour,
                        label: BaseText(
                          value: 'cancel'.tr(),
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.3,
                      child: RoundedButton(
                        radius: 10,
                        label: BaseText(
                          value: 'save'.tr(),
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<UserProfileBloc>().add(
                                  UpdateUserProfileEvent(
                                    userId: user.id,
                                    fullName: fullNameController.text,
                                    email: emailController.text,
                                    avatarUrl: user.avatarUrl,
                                    newImage: image,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
