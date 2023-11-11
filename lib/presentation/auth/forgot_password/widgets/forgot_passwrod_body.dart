import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:grocery_app/presentation/auth/widgets/auth_verify_template.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/components/custom_text_field.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key, required this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSendLinkFailure) {
          showErrorSnackBar(context);
        }
      },
      buildWhen: (previous, current) =>
          current is ForgotPasswordSendLinkSuccess,
      builder: (context, state) {
        if (state is ForgotPasswordSendLinkSuccess) {
          return linkSentBody(context);
        } else {
          return formBody(context);
        }
      },
    );
  }

  BlocBuilder formBody(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is ForgotPasswordSendLinkLoading,
          child: AuthVefiyTemplate(
            appBarTitle: S.of(context).passwordRecovery,
            title: S.of(context).forgotPassword,
            subtitle: S.of(context).lorem,
            field: Form(
              key: BlocProvider.of<ForgotPasswordCubit>(context).formKey,
              child: CustomTextField(
                hintText: S.of(context).emailAddress,
                icon: const Icon(FontAwesomeIcons.envelope),
                inputAction: TextInputAction.done,
                initialValue: email ?? "",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S
                        .of(context)
                        .pleaseEnterEmailThatYouWantRestPassword;
                  }
                  return BlocProvider.of<ForgotPasswordCubit>(context)
                      .errorMessage;
                },
                onSaved: (value) {
                  BlocProvider.of<ForgotPasswordCubit>(context).email = value;
                },
              ),
            ),
            button: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                return BrightButton(
                  isLoading: state is ForgotPasswordSendLinkLoading,
                  text: S.of(context).sendLink,
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    BlocProvider.of<ForgotPasswordCubit>(context)
                        .sendResetLink(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Scaffold linkSentBody(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).passwordRecovery,
        color: MyColors.backgroundSecondry,
      ),
      backgroundColor: MyColors.backgroundPrimary,
      body: CheckConnection(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              SvgPicture.asset("assets/images/auth/verify_email.svg",
                  width: width * 0.7),
              const SizedBox(
                height: 30,
              ),
              Text(S.of(context).resetPassword,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: MyFontWeights.semiBold,
                      fontSize: 25,
                      color: MyColors.text)),
              const SizedBox(
                height: 10,
              ),
              Text(S.of(context).weHaveSentRestPassword,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: MyFontWeights.regular,
                      fontSize: 16,
                      color: MyColors.text)),
              Text(
                  BlocProvider.of<ForgotPasswordCubit>(context).email ??
                      S.of(context).yourEmail,
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
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
                  return AbsorbPointer(
                    absorbing: state is ForgotPasswordSendLinkLoading,
                    child: BrightButton(
                      isLoading: state is ForgotPasswordSendLinkLoading,
                      text: S.of(context).resendLink,
                      onTap: () async {
                        BlocProvider.of<ForgotPasswordCubit>(context)
                            .resendResetLink();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
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
        ),
      ),
    );
  }
}
