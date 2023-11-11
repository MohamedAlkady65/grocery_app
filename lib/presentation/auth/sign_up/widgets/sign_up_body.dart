import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/sign_up_cubit/sign_up_cubit.dart';
import 'package:grocery_app/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:grocery_app/presentation/auth/verify_email/verify_email_screen.dart';
import 'package:grocery_app/presentation/auth/widgets/auth_template.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_text_field.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
        image: "assets/images/auth/auth_signup.png",
        title: S.of(context).createAccount,
        subTitle: S.of(context).quicklyCreateAccount,
        buttomMessage: S.of(context).alreadyHaveAnAccount,
        buttomTextButtonText: S.of(context).login,
        buttomTextButtonOnPressed: () {
          Navigator.pushReplacementNamed(context, SignInScreen.id);
        },
        children: [
          Form(
              key: BlocProvider.of<SignUpCubit>(context).signUpFormKey,
              child: BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state is NoInternet) {
                    showToastWarning(
                        context: context,
                        message: S.of(context).noInternetConnection,
                        top: true);
                  } else if (state is SignUpFailure) {
                    showErrorSnackBar(context);
                  } else if (state is SignUpSuccess) {
                    Navigator.pushNamed(context, VerifyEmailScreen.id,
                        arguments: state.emailVerifyCubit);
                  }
                },
                builder: (context, state) {
                  return AbsorbPointer(
                    absorbing: state is SignUpLoading,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: S.of(context).username,
                          icon: const Icon(Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterYourName;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpFormData
                                .username = value!.trim();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: S.of(context).emailAddress,
                          icon: const Icon(FontAwesomeIcons.envelope),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterYourEmailAddress;
                            }
                            return BlocProvider.of<SignUpCubit>(context)
                                .signUpFormErrorMessages
                                .email;
                          },
                          onSaved: (value) {
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpFormData
                                .email = value!.trim();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: S.of(context).phoneNumber,
                          keyboardType: TextInputType.phone,
                          icon: const Icon(
                            Icons.phone_outlined,
                            size: 28,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterPhoneNumber;
                            }
                            return BlocProvider.of<SignUpCubit>(context)
                                .signUpFormErrorMessages
                                .phone;
                          },
                          onSaved: (value) {
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpFormData
                                .phone = value!.trim();
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterPassword;
                            }
                            return BlocProvider.of<SignUpCubit>(context)
                                .signUpFormErrorMessages
                                .password;
                          },
                          onSaved: (value) {
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpFormData
                                .password = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: S.of(context).confirmPassword,
                          icon: const Icon(
                            Icons.lock_outline,
                            size: 28,
                          ),
                          password: true,
                          inputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseConfirmYourPassword;
                            }
                            return BlocProvider.of<SignUpCubit>(context)
                                .signUpFormErrorMessages
                                .passwordConfirm;
                          },
                          onSaved: (value) {
                            BlocProvider.of<SignUpCubit>(context)
                                .signUpFormData
                                .passwordConfirm = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BrightButton(
                          isLoading: state is SignUpLoading,
                          text: S.of(context).signup,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            BlocProvider.of<SignUpCubit>(context).signUp(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              )),
        ]);
  }
}
