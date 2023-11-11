import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/components/cart_floation_action_button.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/components/filter_icon_button.dart';
import 'package:grocery_app/presentation/products/widgets/featured_products_body.dart';
import 'package:grocery_app/constants/style.dart';

class FeaturedProductsScreen extends StatelessWidget {
  const FeaturedProductsScreen({super.key});
  static const String id = "FeaturedProductsScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      floatingActionButton: const CartFloatingActionButton(),
      appBar: CustomAppBar(
        title: S.of(context).featuredProducts,
        actions: const [FilterIconButton()],
      ),
      body: const CheckConnection(child: FeaturedProductsBody()),
    );
  }
}
