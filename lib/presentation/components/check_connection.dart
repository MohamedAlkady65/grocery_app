import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/connection_cubit/connection_cubit.dart';
import 'package:grocery_app/presentation/components/no_connection_widget.dart';

class CheckConnection extends StatelessWidget {
  const CheckConnection({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionCubit, CheckConnectionState>(
      builder: (context, state) {
        if (state is ConnectionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ConnectionFailure) {
          return const Center(
            child: NoConnectionWidget(),
          );
        } else if (state is ConnectionSuccess) {
          return child;
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
