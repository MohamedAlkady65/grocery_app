import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/logic/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/presentation/auth/change_password/change_password_screen.dart';
import 'package:grocery_app/presentation/auth/verify_phone/send_otp_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';
import 'package:grocery_app/presentation/components/custom_text_field.dart';
import 'package:grocery_app/constants/style.dart';

class AccountDetailsBody extends StatelessWidget {
  const AccountDetailsBody({super.key, required this.keyboard});
  final double keyboard;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateInfoSuccess) {
          Navigator.pop(context);
        } else if (state is ProfileUpdateInfoFailure) {
          showErrorSnackBar(context);
        }
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is ProfileUpdateInfoLoading,
          child: Form(
            key: BlocProvider.of<ProfileCubit>(context).formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomTextField(
                  initialValue:
                      BlocProvider.of<InfoCubit>(context).currentUser?.email ??
                          "",
                  hintText: S.of(context).emailAddress,
                  icon: const Icon(Icons.email_outlined),
                  enabled: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterYourPhoneNumber;
                    } else {
                      return BlocProvider.of<ProfileCubit>(context)
                          .phoneErrorMessage;
                    }
                  },
                  onChanged: (value) {
                    BlocProvider.of<ProfileCubit>(context).phoneText = value;
                  },
                  keyboardType: TextInputType.phone,
                  initialValue: phoneInitialValue(context),
                  hintText: S.of(context).phone,
                  icon: const Icon(Icons.phone_outlined),
                  suffixIcon: verifyButton(context),
                  enabled: !(BlocProvider.of<InfoCubit>(context)
                          .currentUser
                          ?.phoneVerified ??
                      false),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    inputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterUsername;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      BlocProvider.of<ProfileCubit>(context).username = value;
                    },
                    initialValue: BlocProvider.of<InfoCubit>(context)
                            .currentUser
                            ?.username ??
                        "",
                    hintText: S.of(context).username,
                    icon: const Icon(Icons.account_circle_outlined)),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ChangePasswordScreen.id);
                    },
                    color: MyColors.link,
                    child: Text(
                      S.of(context).changePassword,
                      style:  TextStyle(
                          color: MyColors.link,
                          fontWeight: MyFontWeights.medium,
                          fontSize: 16),
                    ),
                  ),
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
                      current is ProfileUpdateInfoValidState,
                  builder: (context, state) {
                    double heightOfNonVaild =
                        state is ProfileUpdateInfoValidState
                            ? state.notValidFieldsCount * 26
                            : 0;
                    double space = MediaQuery.of(context).size.height -
                        keyboard -
                        60 -
                        80 -
                        270 -
                        32 -
                        heightOfNonVaild;

                    if (space < 5) {
                      space = 5;
                    }
                    return SizedBox(
                      height: space,
                    );
                  },
                ),
                BrightButton(
                  isLoading: state is ProfileUpdateInfoLoading,
                  text: S.of(context).save,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    BlocProvider.of<ProfileCubit>(context).updateInfo(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String phoneInitialValue(BuildContext context) {
    final phone = BlocProvider.of<InfoCubit>(context).currentUser?.phone;
    final countryCode =
        BlocProvider.of<InfoCubit>(context).ipInfo?.countryCode2;
    if (phone!.countryCode == countryCode) {
      return phone.national!;
    } else {
      return phone.e164;
    }
  }

  Padding verifyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: CustomTextButton(
        onPressed: () {
          final phone = BlocProvider.of<InfoCubit>(context).currentUser!.phone;
          OtpCubit otpCubit = OtpCubit(
              phone: phone,
              canSkip: false,
              infoCubit: BlocProvider.of<InfoCubit>(context));

          Navigator.pushReplacementNamed(context, SendOTPScreen.id,
              arguments: otpCubit);
        },
        color: MyColors.primaryDark,
        child: Text(
          BlocProvider.of<InfoCubit>(context).currentUser?.phoneVerified ??
                  false
              ? S.of(context).verified
              : S.of(context).verify,
          style:
               TextStyle(fontWeight: MyFontWeights.medium, fontSize: 16),
        ),
      ),
    );
  }
}
