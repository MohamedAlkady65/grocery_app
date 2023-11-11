part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordSendLinkSuccess extends ForgotPasswordState {}

final class ForgotPasswordSendLinkLoading extends ForgotPasswordState {}

final class ForgotPasswordSendLinkFailure extends ForgotPasswordState {}

final class ForgotPasswordSendLinkError extends ForgotPasswordState {}
