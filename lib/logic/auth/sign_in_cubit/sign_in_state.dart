part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInWrong extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInFailure extends SignInState {}

final class SignInSuccessGoVerifyPhone extends SignInSuccess {}

final class SignInSuccessGoVerifyEmail extends SignInSuccess {
  final EmailVerifyCubit emailVerifyCubit;

  SignInSuccessGoVerifyEmail({required this.emailVerifyCubit});
}

final class SignInSuccessGoHome extends SignInSuccess {}

final class NoInternet extends SignInState {}
