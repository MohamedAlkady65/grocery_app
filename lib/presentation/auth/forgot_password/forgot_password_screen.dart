import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/auth/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:grocery_app/presentation/auth/forgot_password/widgets/forgot_passwrod_body.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static const String id = "ForgotPasswordScreen";

  @override
  Widget build(BuildContext context) {
    String? email = ModalRoute.of(context)!.settings.arguments as String?;

    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: ForgotPasswordBody(
        email: email,
      ),
    );
  }
}
