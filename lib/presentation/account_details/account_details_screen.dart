import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/presentation/account_details/widgets/account_details_body.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  static const String id = "AccountDetailsScreen";

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit =
        ModalRoute.of(context)!.settings.arguments as ProfileCubit;
    profileCubit.phoneErrorMessage = null;
    profileCubit.phoneText = null;
    profileCubit.username = null;
    double keybaord = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar:  CustomAppBar(
        title: S.of(context).accountDetails,
      ),
      body: BlocProvider.value(
        value: profileCubit,
        child: CheckConnection(
          child: AccountDetailsBody(
            keyboard: keybaord,
          ),
        ),
      ),
    );
  }
}
