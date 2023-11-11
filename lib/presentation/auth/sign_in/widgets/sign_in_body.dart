import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/logic/auth/sign_in_cubit/sign_in_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';

import 'package:grocery_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:grocery_app/presentation/auth/verify_email/verify_email_screen.dart';
import 'package:grocery_app/presentation/auth/verify_phone/send_otp_screen.dart';
import 'package:grocery_app/presentation/auth/widgets/auth_template.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_text_field.dart';
import 'package:grocery_app/presentation/components/switch_button.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:grocery_app/presentation/home/home_screen.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
        image: "assets/images/auth/auth_login.png",
        title: S.of(context).welcomeBack,
        subTitle: S.of(context).signInToYourAccount,
        buttomMessage: S.of(context).dontHaveAnAccount,
        buttomTextButtonText: S.of(context).signup,
        buttomTextButtonOnPressed: () {
          Navigator.pushReplacementNamed(context, SignUpScreen.id);
        },
        children: [
          BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state is NoInternet) {
                showToastWarning(
                    context: context,
                    message: S.of(context).noInternetConnection,
                    top: true);
              } else if (state is SignInFailure) {
                showErrorSnackBar(context);
              } else if (state is SignInSuccess) {
                if (state is SignInSuccessGoVerifyEmail) {
                  Navigator.pushNamed(context, VerifyEmailScreen.id,
                      arguments: state.emailVerifyCubit);
                } else if (state is SignInSuccessGoVerifyPhone) {
                  final infoCubit = BlocProvider.of<InfoCubit>(context);
                  Navigator.pushReplacementNamed(context, SendOTPScreen.id,
                      arguments: OtpCubit(
                          phone: infoCubit.currentUser!.phone,
                          canSkip: true,
                          infoCubit: infoCubit));
                }
                if (state is SignInSuccessGoHome) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false);
                }
              }
            },
            builder: (context, state) {
              return AbsorbPointer(
                absorbing: state is SignInLoading,
                child: Form(
                    key: BlocProvider.of<SignInCubit>(context).signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: S.of(context).emailAddress,
                          icon: const Icon(FontAwesomeIcons.envelope),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterYourEmailAddress;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            BlocProvider.of<SignInCubit>(context)
                                .signInFormData
                                .email = value!.trim();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: S.of(context).password,
                          icon: const Icon(
                            Icons.lock_outline,
                            size: 28,
                          ),
                          password: true,
                          inputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterYourPassword;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            BlocProvider.of<SignInCubit>(context)
                                .signInFormData
                                .password = value!.trim();
                          },
                        ),
                      ],
                    )),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SwitchButton(
                scale: 0.8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 6, bottom: 3),
                child: Text(
                  S.of(context).rememberMe,
                  style:  TextStyle(
                      fontSize: 13,
                      fontWeight: MyFontWeights.medium,
                      color: MyColors.textSecondry),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        MyColors.link.withOpacity(0.1))),
                onPressed: () {
                  String? email;
                  if (BlocProvider.of<SignInCubit>(context).state
                      is SignInWrong) {
                    email = BlocProvider.of<SignInCubit>(context)
                            .signInFormData
                            .email ??
                        "";
                  }
                  Navigator.pushNamed(context, ForgotPasswordScreen.id,
                      arguments: email);
                },
                child: Text(
                  S.of(context).forgotPasswordQu,
                  style:  TextStyle(
                      color: MyColors.link,
                      fontWeight: MyFontWeights.medium,
                      fontSize: 13),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              return BrightButton(
                isLoading: state is SignInLoading,
                text: S.of(context).login,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  BlocProvider.of<SignInCubit>(context).signIn();
                },
              );
            },
          ),
          message(),
        ]);
  }

  Widget message() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        if (state is SignInWrong) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: MyColors.redDelete,
                ),
                Text(
                  S.of(context).incorrectEmailAddressOrPassword,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                      color: MyColors.redDelete,
                      fontSize: 15,
                      fontWeight: MyFontWeights.medium),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
