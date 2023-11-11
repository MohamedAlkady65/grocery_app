import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/auth/sign_in_cubit/sign_in_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/presentation/auth/sign_in/widgets/sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String id = "SignInScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(BlocProvider.of<InfoCubit>(context)),
      child: const SignInBody(),
    );
  }
}
