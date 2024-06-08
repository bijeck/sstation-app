import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/utils/messages.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
import 'package:sstation/features/profile/domain/usecases/change_password.dart';
import 'package:sstation/features/profile/domain/usecases/init_user_profile.dart';
import 'package:sstation/features/profile/domain/usecases/update_user_profile.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

@Injectable()
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({
    required InitUserProfile initUserProfile,
    required UpdateUserProfile updateUserProfile,
    required ChangePassword changedPassword,
  })  : _initUserProfile = initUserProfile,
        _updateUserProfile = updateUserProfile,
        _changedPassword = changedPassword,
        super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) {
      emit(UserProfileLoading());
    });
    on<InitUserProfileEvent>(_initUserProfileHandler);
    on<UpdateUserProfileEvent>(_updateUserProfileHandler);
    on<ChangePasswordEvent>(_changedPasswordHandler);
  }

  final InitUserProfile _initUserProfile;
  final UpdateUserProfile _updateUserProfile;
  final ChangePassword _changedPassword;

  Future<void> _updateUserProfileHandler(
    UpdateUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    final result = await _updateUserProfile(
      UpdateProfileParams(
        userId: event.userId,
        fullName: event.fullName,
        email: event.email,
        avatarUrl: event.avatarUrl,
        newImage: event.newImage,
      ),
    );
    result.fold(
      (failure) => emit(UserProfileError(AppMessage.serverError)),
      (user) => emit(UpdatedUserProfile()),
    );
  }

  Future<void> _initUserProfileHandler(
    InitUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    final result = await _initUserProfile();
    result.fold(
      (failure) => emit(UserProfileError(AppMessage.serverError)),
      (user) => emit(UserProfileLoaded(user)),
    );
  }

  Future<void> _changedPasswordHandler(
    ChangePasswordEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    final result = await _changedPassword(
      ChangePasswordParams(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ),
    );
    result.fold(
      (failure) => emit(UserProfileError(int.parse(failure.statusCode) == 400
          ? failure.errorMessage
          : AppMessage.serverError)),
      (_) => emit(const ChangedPassword()),
    );
  }
}
