import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/auth/email_verify_cubit/email_verify_cubit.dart';
import 'package:grocery_app/presentation/auth/verify_email/widgets/verify_email_body.dart';


class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});
  static const String id = "VerifyEmailScreen";

  @override
  Widget build(BuildContext context) {
    EmailVerifyCubit emailVerifyCubit =
        ModalRoute.of(context)!.settings.arguments as EmailVerifyCubit;

    return BlocProvider(
      create: (context) => emailVerifyCubit,
      child: const VerifyEmailBody(),
    );
  }
}
