// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sstation/core/common/app/navigator.dart';

import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/features/dashboard/presentation/views/home_page_screen.dart';
import 'package:sstation/features/profile/presentation/bloc/user_profile_bloc.dart';

class StagingScreen extends StatefulWidget {
  const StagingScreen({
    super.key,
    required this.forwardRoute,
    required this.param,
  });
  final String forwardRoute;
  final Map<String, String> param;
  static const routeName = 'staging';
  @override
  State<StagingScreen> createState() => _StagingScreenState();
}

class _StagingScreenState extends State<StagingScreen> {
  @override
  void initState() {
    context.read<UserProfileBloc>().add(const InitUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileLoaded) {
          context.userProvider.initUser(state.user);
          AppNavigator.pauseAndPushNewScreenWithoutBack(
            context: context,
            routname: widget.forwardRoute.isEmpty
                ? HomePage.routeName
                : widget.forwardRoute,
            delayTime: 0,
            arguments: widget.param,
          );
        } else if (state is UserProfileError) {}
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
