part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class SignOutState extends ProfileState {}

final class ProfileUpdateInfoSuccess extends ProfileState {}

final class ProfileUpdateInfoFailure extends ProfileState {}

final class ProfileUpdateInfoLoading extends ProfileState {}

final class ProfileUpdateInfoValidState extends ProfileState {
  final int notValidFieldsCount;

  ProfileUpdateInfoValidState(this.notValidFieldsCount);
}

final class UploadUserImage extends ProfileState {}

final class UploadUserImageSuccess extends UploadUserImage {}

final class UploadUserImageFailure extends UploadUserImage {}

final class UploadUserImageLoading extends UploadUserImage {}

final class SignOutLoading extends SignOutState {}

final class SignOutSuccess extends SignOutState {}

final class SignOutFailure extends SignOutState {}
