import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/presentation/auth/verify_phone/submit_otp_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/components/phone_text_field.dart';
import 'package:grocery_app/presentation/home/home_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SendOTPBody extends StatelessWidget {
  const SendOTPBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: S.of(context).verifyNumber,
        color: MyColors.backgroundSecondry,
        actions: BlocProvider.of<OtpCubit>(context).canSkip
            ? [skipButton(context)]
            : null,
        backIcon: !BlocProvider.of<OtpCubit>(context).canSkip,
      ),
      body: CheckConnection(
        child: BlocConsumer<OtpCubit, OtpState>(
          listener: (context, state) {
            if (state is OTPFailure) {
              showErrorSnackBar(context, message: state.message);
            } else if (state is OTPSent) {
              OtpCubit otpCubit = BlocProvider.of<OtpCubit>(context);

              Navigator.pushNamed(context, SubmitOTPScreen.id,
                  arguments: otpCubit);
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is OTPSendLoading,
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
                    S.of(context).lorem,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                        fontWeight: MyFontWeights.regular,
                        fontSize: 15,
                        color: MyColors.textSecondry),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PhoneTextField(
                    phoneTextFieldKey:
                        BlocProvider.of<OtpCubit>(context).phoneFieldKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterYourPhoneNumber;
                      }
                      return BlocProvider.of<OtpCubit>(context)
                          .phoneFieldErrorMessage;
                    },
                    initialValue: PhoneNumber(
                        isoCode: BlocProvider.of<OtpCubit>(context)
                            .phone!
                            .countryCode,
                        phoneNumber:
                            BlocProvider.of<OtpCubit>(context).phone!.e164),
                    onInputChanged: (phone) {
                      BlocProvider.of<OtpCubit>(context).phone = PhoneModel(
                          countryCode: phone.isoCode ?? "",
                          e164: phone.phoneNumber ?? "");
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BrightButton(
                      isLoading: state is OTPSendLoading,
                      text: S.of(context).next,
                      onTap: () async {
                        FocusManager.instance.primaryFocus!.unfocus();
                        BlocProvider.of<OtpCubit>(context).sendOTP(context);
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox skipButton(BuildContext context) {
    return SizedBox(
      width: 56.0,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999999),
          )),
          overlayColor:
              MaterialStateProperty.all(MyColors.text.withOpacity(0.1)),
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.id, (route) => false);
        },
        child: Text(
          S.of(context).skip,
          style: TextStyle(
              color: MyColors.text,
              fontWeight: MyFontWeights.medium,
              fontSize: 16),
        ),
      ),
    );
  }
}
