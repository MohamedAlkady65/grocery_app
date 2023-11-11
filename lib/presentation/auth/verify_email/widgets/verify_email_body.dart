import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/email_verify_cubit/email_verify_cubit.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/presentation/auth/verify_phone/send_otp_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';

class VerifyEmailBody extends StatelessWidget {
  const VerifyEmailBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final String email = BlocProvider.of<EmailVerifyCubit>(context).email;

    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: S.of(context).verifyEmail,
        color: MyColors.backgroundSecondry,
      ),
      body: CheckConnection(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocConsumer<EmailVerifyCubit, EmailVerifyState>(
            listener: (context, state) {
              if (state is EmailResendSuccess) {
                showSuccessSnackBar(context,
                    title: S.of(context).emailSent,
                    message: S.of(context).haveResendToYouVerificationLink);
              } else if (state is EmailResendFailure) {
                showErrorSnackBar(context,
                    message: S.of(context).cannotSendVerificationLinkNow);
              }
            },
            buildWhen: (previous, current) => current is EmailVerifyVerified,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state is EmailVerifyVerified
                    ? thankYouVerifyBody(width: width, context: context)
                    : verifyBody(width: width, context: context, email: email),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> thankYouVerifyBody(
      {required BuildContext context, required double width}) {
    return [
      const Spacer(
        flex: 1,
      ),
      SvgPicture.asset("assets/images/auth/thank_verify_email.svg",
          width: width * 0.7),
      const SizedBox(
        height: 30,
      ),
      Text(S.of(context).thankYou,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: MyFontWeights.semiBold,
              fontSize: 25,
              color: MyColors.text)),
      const SizedBox(
        height: 10,
      ),
      Text(S.of(context).verifiedSuccessfully,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: MyFontWeights.regular,
              fontSize: 16,
              color: MyColors.text)),
      const SizedBox(
        height: 30,
      ),
      BlocBuilder<EmailVerifyCubit, EmailVerifyState>(
        builder: (context, state) {
          return BrightButton(
              isLoading: state is EmailVerifyLoading,
              onTap: () {
                emailVerifyContinue(context);
              },
              text: S.of(context).continuee);
        },
      ),
      const Spacer(
        flex: 3,
      ),
    ];
  }

  List<Widget> verifyBody(
      {required String email,
      required double width,
      required BuildContext context}) {
    return [
      const Spacer(
        flex: 1,
      ),
      SvgPicture.asset("assets/images/auth/verify_email.svg",
          width: width * 0.7),
      const SizedBox(
        height: 30,
      ),
      Text(S.of(context).verifyYourEmailAddress,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: MyFontWeights.semiBold,
              fontSize: 25,
              color: MyColors.text)),
      const SizedBox(
        height: 10,
      ),
      Text(S.of(context).sentVerificationLink,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: MyFontWeights.regular,
              fontSize: 16,
              color: MyColors.text)),
      Text(email,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: MyFontWeights.semiBold,
              fontSize: 16,
              color: MyColors.text)),
      const SizedBox(
        height: 20,
      ),
      Text(S.of(context).clickLinkToCompleteVerification,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: MyFontWeights.regular,
              fontSize: 16,
              color: MyColors.text)),
      const SizedBox(
        height: 30,
      ),
      BlocBuilder<EmailVerifyCubit, EmailVerifyState>(
        builder: (context, state) {
          return BrightButton(
              isLoading: state is EmailVerifyLoading,
              onTap: () {
                BlocProvider.of<EmailVerifyCubit>(context)
                    .resendVerficationLinkEmail();
              },
              text: S.of(context).resendLink);
        },
      ),
      const Spacer(
        flex: 3,
      ),
    ];
  }

  void emailVerifyContinue(BuildContext context) {
    final phone = BlocProvider.of<EmailVerifyCubit>(context).phone;
    OtpCubit otpCubit = OtpCubit(
        phone: phone,
        canSkip: true,
        infoCubit: BlocProvider.of<InfoCubit>(context));

    Navigator.pushReplacementNamed(context, SendOTPScreen.id,
        arguments: otpCubit);
  }
}
