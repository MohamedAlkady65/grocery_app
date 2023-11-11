part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class PhoneCodeCompleted extends OtpState {}

final class OTPSendLoading extends OtpState {}

final class OTPSent extends OtpState {}

final class OTPCorrect extends OtpState {}

final class OTPWrong extends OtpState {}

final class OTPEmpty extends OtpState {}

final class OTPSubmitLoading extends OtpState {}

final class OTPFailure extends OtpState {
  final String? message;

  OTPFailure({this.message});
}
