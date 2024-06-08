part of 'user_profile_bloc.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  const UserProfileLoaded(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

class UpdatedUserProfile extends UserProfileState {}

class UserProfileError extends UserProfileState {
  const UserProfileError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class ChangedPassword extends UserProfileState {
  const ChangedPassword();

  @override
  List<String> get props => [];
}