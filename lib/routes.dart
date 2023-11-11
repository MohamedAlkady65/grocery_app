import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/logic/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/account_details/account_details_screen.dart';
import 'package:grocery_app/presentation/add_address/add_address_screen.dart';
import 'package:grocery_app/presentation/auth/change_password/change_password_screen.dart';
import 'package:grocery_app/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:grocery_app/presentation/auth/widgets/auth_welcome_screen.dart';
import 'package:grocery_app/presentation/checkout/checkout_screen.dart';
import 'package:grocery_app/presentation/my_addresses/my_addresses_screen.dart';
import 'package:grocery_app/presentation/order_details/order_details_screen.dart';
import 'package:grocery_app/presentation/payment/payment_screen.dart';
import 'package:grocery_app/presentation/reviews/add_review_screen.dart';
import 'package:grocery_app/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:grocery_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:grocery_app/presentation/auth/verify_phone/submit_otp_screen.dart';
import 'package:grocery_app/presentation/auth/verify_phone/send_otp_screen.dart';
import 'package:grocery_app/presentation/cart/cart_screen.dart';
import 'package:grocery_app/presentation/categories/categories_screen.dart';
import 'package:grocery_app/presentation/products/featured_products_screen.dart';
import 'package:grocery_app/presentation/home/home_screen.dart';
import 'package:grocery_app/presentation/intro/intro_screen.dart';
import 'package:grocery_app/presentation/orders/my_orders_screens.dart';
import 'package:grocery_app/presentation/product_details/product_details_screen.dart';
import 'package:grocery_app/presentation/settings/settings_screen.dart';
import 'package:grocery_app/presentation/products/products_category_screen.dart';
import 'package:grocery_app/presentation/reviews/reviews_screen.dart';
import 'package:grocery_app/presentation/auth/verify_email/verify_email_screen.dart';
import 'package:grocery_app/presentation/upload_test/upload_test_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  IntroScreen.id: (context) => const IntroScreen(),
  HomeScreen.id: (context) => HomeScreen(),
  CategiriesScreen.id: (context) => const CategiriesScreen(),
  ProductsCategoryScreen.id: (context) => const ProductsCategoryScreen(),
  FeaturedProductsScreen.id: (context) => const FeaturedProductsScreen(),
  CartScreen.id: (context) => BlocProvider(
        create: (context) => CartCubit(BlocProvider.of<ProductsCubit>(context)),
        child: const CartScreen(),
      ),
  AuthWelcomeScreen.id: (context) => const AuthWelcomeScreen(),
  SignInScreen.id: (context) => const SignInScreen(),
  SignUpScreen.id: (context) => const SignUpScreen(),
  SendOTPScreen.id: (context) => const SendOTPScreen(),
  SubmitOTPScreen.id: (context) => const SubmitOTPScreen(),
  ReviewsScreen.id: (context) => const ReviewsScreen(),
  AddReviewScreen.id: (context) => const AddReviewScreen(),
  ProductDetailsScreen.id: (context) => const ProductDetailsScreen(),
  VerifyEmailScreen.id: (context) => const VerifyEmailScreen(),
  PaymentScreen.id: (context) => const PaymentScreen(),
  AccountDetailsScreen.id: (context) => const AccountDetailsScreen(),
  ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
  MyOrdersScreen.id: (context) => const MyOrdersScreen(),
  OrderDetailsScreen.id: (context) => const OrderDetailsScreen(),
  MyAddressesScreen.id: (context) => BlocProvider(
        create: (context) =>
            AddressesCubit(infoCubit: BlocProvider.of<InfoCubit>(context)),
        child: const MyAddressesScreen(),
      ),
  AddAdderssScreen.id: (context) => const AddAdderssScreen(),
  SettingsScreen.id: (context) => SettingsScreen(),
  ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
  CheckoutScreen.id: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AddressesCubit(infoCubit: BlocProvider.of<InfoCubit>(context)),
          ),
          BlocProvider(
            create: (context) => CheckoutCubit(),
          ),
        ],
        child: const CheckoutScreen(),
      ),
  UplaodTestScreen.id: (context) => const UplaodTestScreen(),
};
