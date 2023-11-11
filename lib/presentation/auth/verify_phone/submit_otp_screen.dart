import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/presentation/auth/verify_phone/widgets/submit_otp_body.dart';

class SubmitOTPScreen extends StatelessWidget {
  const SubmitOTPScreen({super.key});
  static const String id = "SubmitOTPScreen";

  @override
  Widget build(BuildContext context) {
    OtpCubit otpCubit = ModalRoute.of(context)!.settings.arguments as OtpCubit;
    return BlocProvider.value(
      value: otpCubit,
      child: const SubmitOTPBody(),
    );
  }
}
