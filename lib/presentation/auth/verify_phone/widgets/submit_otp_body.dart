import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/presentation/auth/verify_phone/widgets/otp_field.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';
import 'package:grocery_app/presentation/home/home_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';

class SubmitOTPBody extends StatelessWidget {
  const SubmitOTPBody({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: MyColors.backgroundSecondry,
        appBar: CustomAppBar(
          title: S.of(context).verifyNumber,
          color: MyColors.backgroundSecondry,
          backIcon: false,
        ),
        body: CheckConnection(
          child: BlocConsumer<OtpCubit, OtpState>(
            listener: (context, state) {
              if (state is OTPFailure) {
                showErrorSnackBar(context, message: state.message);
              }
            },
            buildWhen: (previous, current) => current is OTPCorrect,
            builder: (context, state) {
              return state is OTPCorrect
                  ? thankYouVerifyBody(context)
                  : submitBody(context);
            },
          ),
        ),
      ),
    );
  }

  Padding thankYouVerifyBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          SvgPicture.asset(
            "assets/images/auth/phone_verified.svg",
            height: 300,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(S.of(context).phoneNumberVerified,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: MyFontWeights.semiBold,
                  fontSize: 25,
                  color: MyColors.text)),
          const SizedBox(
            height: 10,
          ),
          Text(S.of(context).youHaveVerifiedYorPhoneSuccessfully,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: MyFontWeights.regular,
                  fontSize: 16,
                  color: MyColors.text)),
          const SizedBox(
            height: 30,
          ),
          BrightButton(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.id, (route) => false);
              },
              text: S.of(context).startShopping),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }

  Widget submitBody(BuildContext context) {
    String phone = BlocProvider.of<OtpCubit>(context).phone!.e164;
    phone = phone == "" ? S.of(context).yourNumber : phone;
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is OTPSubmitLoading,
          child: ListView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 64),
            children: [
              Text(
                S.of(context).verifyYourNumber,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: MyFontWeights.semiBold,
                    fontSize: 25,
                    color: MyColors.text),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "We have sent code to $phone",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: MyFontWeights.medium,
                    fontSize: 16,
                    color: MyColors.text),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                S.of(context).enterYourOtpCodeBelow,
                textAlign: TextAlign.center,
                style:  TextStyle(
                    fontWeight: MyFontWeights.regular,
                    fontSize: 15,
                    color: MyColors.textSecondry),
              ),
              const SizedBox(
                height: 20,
              ),
              otpField(context),
              const SizedBox(
                height: 10,
              ),
              message(),
              const SizedBox(
                height: 10,
              ),
              verifyButton(),
              editPhoneNumber(context),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  Align editPhoneNumber(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomTextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: MyColors.link,
        child: Text(
          S.of(context).editPhoneNumber,
          style:  TextStyle(
              color: MyColors.link,
              fontWeight: MyFontWeights.medium,
              fontSize: 14),
        ),
      ),
    );
  }

  SizedBox otpField(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Center(
        child: OtpInput(
          controller: BlocProvider.of<OtpCubit>(context).pinputController,
          onCompleted: (value) {
            BlocProvider.of<OtpCubit>(context).submitOTP(otpCode: value);
          },
        ),
      ),
    );
  }

  Widget verifyButton() {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        return BrightButton(
          isLoading: state is OTPSubmitLoading,
          text: S.of(context).verify,
          onTap: () {
            BlocProvider.of<OtpCubit>(context).submitOTP(
              otpCode: BlocProvider.of<OtpCubit>(context).pinputController.text,
            );
          },
        );
      },
    );
  }

  Widget message() {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        if (state is OTPWrong) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: MyColors.redDelete,
                ),
                Text(
                  S.of(context).incorrectVerificationCode,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                      color: MyColors.redDelete,
                      fontSize: 16,
                      fontWeight: MyFontWeights.medium),
                ),
              ],
            ),
          );
        } else if (state is OTPEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              S.of(context).pleaseEnterOtpCodeBeforeSubmit,
              textAlign: TextAlign.center,
              style:  TextStyle(
                  color: MyColors.redDelete,
                  fontSize: 16,
                  fontWeight: MyFontWeights.medium),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
