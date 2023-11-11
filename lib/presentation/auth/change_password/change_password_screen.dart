import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/auth/change_password_cubit/change_password_cubit.dart';
import 'package:grocery_app/presentation/auth/change_password/widgets/change_password_body.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  static const String id = "ChangePasswordScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundSecondry,
        appBar:  CustomAppBar(
          title: S.of(context).changePassword,
        ),
        body: BlocProvider(
          create: (context) => ChangePasswordCubit(),
          child: const CheckConnection(child: ChangePasswordbody()),
        ));
  }
}
