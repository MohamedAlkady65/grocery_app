import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/change_password_cubit/change_password_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';
import 'package:grocery_app/presentation/components/custom_text_field.dart';

class ChangePasswordbody extends StatelessWidget {
  const ChangePasswordbody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordError) {
          showErrorSnackBar(context);
        }
      },
      buildWhen: (previous, current) => current is ChangePasswordSuccess,
      builder: (context, state) {
        if (state is ChangePasswordSuccess) {
          return successBody(context);
        } else {
          return form(context);
        }
      },
    );
  }

  BlocBuilder form(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is ChangePasswordLoading,
          child: Form(
            key: BlocProvider.of<ChangePasswordCubit>(context).formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomTextField(
                  hintText: S.of(context).currentPassword,
                  icon: const Icon(Icons.lock_outline),
                  password: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterCurrentPassword;
                    }
                    return BlocProvider.of<ChangePasswordCubit>(context)
                        .formErrorMessages
                        .currentPassword;
                  },
                  onSaved: (value) {
                    BlocProvider.of<ChangePasswordCubit>(context)
                        .formData
                        .currentPassword = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: S.of(context).newPassword,
                  icon: const Icon(Icons.lock_outline),
                  password: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterNewPassword;
                    }
                    return BlocProvider.of<ChangePasswordCubit>(context)
                        .formErrorMessages
                        .newPassword;
                  },
                  onSaved: (value) {
                    BlocProvider.of<ChangePasswordCubit>(context)
                        .formData
                        .password = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: S.of(context).confirmPassword,
                  icon: const Icon(Icons.lock_outline),
                  inputAction: TextInputAction.done,
                  password: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseConfirmYourNewPassword;
                    }
                    return BlocProvider.of<ChangePasswordCubit>(context)
                        .formErrorMessages
                        .newPasswordConfirm;
                  },
                  onSaved: (value) {
                    BlocProvider.of<ChangePasswordCubit>(context)
                        .formData
                        .passwordConfirm = value;
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextButton(
                    onPressed: () {
                      String? email = BlocProvider.of<InfoCubit>(context)
                          .currentUser
                          ?.email;
                      Navigator.pushNamed(context, ForgotPasswordScreen.id,
                          arguments: email);
                    },
                    color: MyColors.link,
                    child: Text(
                      S.of(context).forgotPasswordQu,
                      style:  TextStyle(
                          color: MyColors.link,
                          fontWeight: MyFontWeights.medium,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BrightButton(
                  isLoading: state is ChangePasswordLoading,
                  text: S.of(context).change,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    BlocProvider.of<ChangePasswordCubit>(context)
                        .changePassword(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget successBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          const Icon(
            FontAwesomeIcons.circleCheck,
            color: MyColors.primaryDark,
            size: 180,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(S.of(context).passwordChanged,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: MyFontWeights.semiBold,
                  fontSize: 25,
                  color: MyColors.text)),
          const SizedBox(
            height: 10,
          ),
          Text(S.of(context).yourPasswordHasBeenChangedSuccessfully,
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
                Navigator.pop(context);
              },
              text: S.of(context).back),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
