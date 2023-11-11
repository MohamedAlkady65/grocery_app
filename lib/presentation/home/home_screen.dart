import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/favorites_cubit/favorites_cubit.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/account/account_body.dart';
import 'package:grocery_app/presentation/components/cart_floation_action_button.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/components/icon_button_app_bar_action.dart';
import 'package:grocery_app/presentation/home/widgets/custom_bottom_app_bar.dart';
import 'package:grocery_app/presentation/favorites/favorites_body.dart';
import 'package:grocery_app/presentation/home/home_body.dart';
import 'package:grocery_app/constants/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  late List<Widget> screens;
  late List<PreferredSizeWidget?> appbars;

  void init() {
    FavoritesCubit favoritesCubit =
        FavoritesCubit(BlocProvider.of<ProductsCubit>(context));
    screens = [
      const HomeBody(),
      const AccountBody(),
      FavoritesBody(
        favoritesCubit: favoritesCubit,
      ),
    ];
    appbars = [
      null,
      null,
      CustomAppBar(
        title: S.of(context).favorites,
        backIcon: false,
        actions: [
          clearFavoritesButton(context: context, favoritesCubit: favoritesCubit)
        ],
      ),
    ];
  }

  int previousIndex = 0;

  @override
  Widget build(BuildContext context) {
    init();
    return WillPopScope(
      onWillPop: backButtonCalBack,
      child: Scaffold(
        backgroundColor: MyColors.backgroundSecondry,
        extendBody: true,
        body: CheckConnection(key: UniqueKey(), child: screens[currentIndex]),
        appBar: appbars[currentIndex],
        // ignore: prefer_const_constructors
        floatingActionButton: CartFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: CustomBottomAppBar(
          onTap: (index) {
            previousIndex = currentIndex;
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
        ),
      ),
    );
  }

  Future<bool> backButtonCalBack() async {
    if (currentIndex == 0) {
      return backButtonCalBackAtHome();
    } else {
      setState(() {
        currentIndex = previousIndex;
      });
      previousIndex = 0;
      return false;
    }
  }

  DateTime? previousTime;
  bool backButtonCalBackAtHome() {
    final now = DateTime.now();
    if (previousTime == null ||
        now.difference(previousTime!) > const Duration(milliseconds: 1500)) {
      previousTime = now;
      showDefaultToast(context, S.of(context).pressBackButtonAgainToExit);
      return false;
    } else {
      return true;
    }
  }

  BlocBuilder clearFavoritesButton(
          {required BuildContext context,
          required FavoritesCubit favoritesCubit}) =>
      BlocBuilder<FavoritesCubit, FavoritesState>(
        bloc: favoritesCubit,
        builder: (context, state) {
          if (state is FavoriteProductsSuccess &&
              favoritesCubit.favoritesProducts.isNotEmpty) {
            return IconButtonAppBarAction(
              icon: Icon(
                FontAwesomeIcons.solidTrashCan,
                color: MyColors.text,
                size: 20,
              ),
              onPressed: () {
                showSuringDIalog(
                  context: context,
                  title: S.of(context).deleteFavorites,
                  content: S.of(context).areYouSureToDeleteAllYourFavorites,
                  okCallBack: () async {
                    Navigator.pop(context);
                    showLoadingDIalog(context);
                    await favoritesCubit.clearFavorites();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      );
}
