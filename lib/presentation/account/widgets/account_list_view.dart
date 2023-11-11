import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/presentation/auth/widgets/auth_welcome_screen.dart';
import 'package:grocery_app/presentation/my_addresses/my_addresses_screen.dart';
import 'package:grocery_app/presentation/orders/my_orders_screens.dart';
import 'package:grocery_app/presentation/account/widgets/account_item.dart';
import 'package:grocery_app/presentation/account_details/account_details_screen.dart';
import 'package:grocery_app/presentation/settings/settings_screen.dart';

class AccountListView extends StatelessWidget {
  const AccountListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          AccountItem(
            text: S.of(context).accountDetails,
            icon: Icons.account_circle_outlined,
            onTap: () {
              ProfileCubit profileCubit =
                  BlocProvider.of<ProfileCubit>(context);

              Navigator.pushNamed(context, AccountDetailsScreen.id,
                  arguments: profileCubit);
            },
          ),
          AccountItem(
            text: S.of(context).myOrders,
            icon: Icons.inventory_2_outlined,
            screenId: MyOrdersScreen.id,
          ),
          AccountItem(
            text: S.of(context).myAddresses,
            icon: Icons.location_on_outlined,
            screenId: MyAddressesScreen.id,
          ),
          AccountItem(
            text: S.of(context).settings,
            icon: Icons.settings,
            screenId: SettingsScreen.id,
          ),
          BlocListener<ProfileCubit, ProfileState>(
            listenWhen: (previous, current) => current is SignOutState,
            listener: (context, state) {
              if (state is SignOutLoading) {
                showLoadingDIalog(context);
              } else if (state is SignOutFailure) {
                Navigator.pop(context);
                showErrorSnackBar(context);
              } else if (state is SignOutSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthWelcomeScreen.id, (route) => false);
              }
            },
            child: AccountItem(
              text: S.of(context).signOut,
              icon: Icons.logout,
              arrow: false,
              onTap: () {
                BlocProvider.of<ProfileCubit>(context).signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
