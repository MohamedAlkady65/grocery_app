import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/logic/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/presentation/account/widgets/account_info.dart';
import 'package:grocery_app/presentation/account/widgets/account_list_view.dart';
import 'package:grocery_app/constants/style.dart';

class AccountBody extends StatelessWidget {
  const AccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(BlocProvider.of<InfoCubit>(context)),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: MyColors.backgroundPrimary,
                    height: 100,
                  ),
                  Container(
                    color: MyColors.backgroundSecondry,
                    height: 100,
                  ),
                ],
              ),
              const Positioned.fill(
                  child: Center(
                child: AccountInfo(),
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: AccountListView(),
          ),
        ],
      ),
    );
  }
}
