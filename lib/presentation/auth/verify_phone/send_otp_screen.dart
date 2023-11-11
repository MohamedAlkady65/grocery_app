import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/presentation/auth/verify_phone/widgets/send_otp_body.dart';

class SendOTPScreen extends StatelessWidget {
  const SendOTPScreen({super.key});
  static const String id = "SendOTPScreen";

  @override
  Widget build(BuildContext context) {
    OtpCubit otpCubit = ModalRoute.of(context)!.settings.arguments as OtpCubit;
    return BlocProvider(
      create: (context) => otpCubit,
      child: const SendOTPBody(),
    );
  }
}
