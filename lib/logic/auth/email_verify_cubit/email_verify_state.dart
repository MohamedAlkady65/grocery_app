part of 'email_verify_cubit.dart';

@immutable
sealed class EmailVerifyState {}

final class EmailVerifyInitial extends EmailVerifyState {}

final class EmailVerifyVerified extends EmailVerifyState {}

final class EmailVerifyNotVerified extends EmailVerifyState {}

final class EmailVerifyLoading extends EmailVerifyState {}

final class EmailResendSuccess extends EmailVerifyState {}

final class EmailResendFailure extends EmailVerifyState {}
