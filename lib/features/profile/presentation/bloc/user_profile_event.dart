part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class InitUserProfileEvent extends UserProfileEvent {
  const InitUserProfileEvent();
}

class UpdateUserProfileEvent extends UserProfileEvent {
  const UpdateUserProfileEvent({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.newImage,
  });
  final String userId;
  final String fullName;
  final String email;
  final String avatarUrl;
  final File? newImage;

  @override
  List<Object> get props => [userId, fullName, email, avatarUrl];
}


class ChangePasswordEvent extends UserProfileEvent {
  const ChangePasswordEvent(
      {required this.oldPassword, required this.newPassword});

  final String oldPassword;
  final String newPassword;

  @override
  List<String> get props => [oldPassword, newPassword];
}
