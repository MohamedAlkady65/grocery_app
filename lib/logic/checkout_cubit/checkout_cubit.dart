import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/order_item_model.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/data/models/payment_invoice_model.dart';
import 'package:grocery_app/data/services/orders_services.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/helper/objects.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/logic/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/presentation/payment/payment_screen.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  OrdersServices ordersServices = OrdersServices();

  int currentStep = 0;
  String? choosenAddress;
  PaymentMethod? _choosenMethod;
  List<OrderItemModel> orderItems = [];
  double totalPrice = 0;
  int orderItemsCount = 0;
  String? transactionId;
  String? orderId;
  late OrderModel successOrder;

  void makeOrderData(BuildContext context) async {
    CartCubit cartCubit = BlocProvider.of<CartCubit>(context);

    orderItems = cartCubit.cartItems.map((e) {
      totalPrice += roundSafty(e.product.price * e.count);
      orderItemsCount += e.count;
      final img = e.product.images.firstWhere(
        (element) => element.isDefault,
      );
      return OrderItemModel(
        count: e.count,
        price: e.product.price,
        quantity: e.product.quantity,
        productId: e.product.id,
        title: e.product.title,
        imgUrl: img.imgUrl,
      );
    }).toList();

    orderId = await getOrderId();

    totalPrice = roundSafty(totalPrice);
  }

  Future<String> getOrderId() async {
    String orderId = randNumFixedDigits(kOrderIdLength);
    if (await checkOrderIdExists(orderId)) {
      return getOrderId();
    } else {
      return orderId;
    }
  }

  Future<bool> checkOrderIdExists(String orderId) async =>
      await ordersServices.checkOrderIdExists(orderId);

  set choosenMethod(PaymentMethod? value) {
    _choosenMethod = value;
    emit(CheckoutChangePaymentMethod());
  }

  PaymentMethod? get choosenMethod => _choosenMethod;

  void nextStep() {
    if (currentStep < 2) {
      currentStep++;
      choosenMethod = null;
      emit(CheckoutChangeStep());
    }
  }

  void previousStep(BuildContext context) {
    switch (currentStep) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        currentStep--;
        emit(CheckoutChangeStep());
        break;
      case 2:
        Navigator.pop(context);
        Navigator.pop(context);
        break;
    }
  }

  void confirmButton(BuildContext context) async {
    if (_choosenMethod == null) {
      showToastWarning(
          context: context, message: S.of(context).pleaseChoosePaymentMethod);
    } else if (_choosenMethod == PaymentMethod.cash) {
      await cashMethodExecute(context);
    } else if (_choosenMethod == PaymentMethod.creditCard) {
      await creditMethodExecute(context);
    }
  }

  Future<void> cashMethodExecute(BuildContext context) async {
    await orderExecute(context);
  }

  Future<void> creditMethodExecute(BuildContext context) async {
    final user = BlocProvider.of<InfoCubit>(context).currentUser;

    int priceInCent = roundSafty(totalPrice * 100).floor();

    PaymentInvoiceModel paymentInvoice = PaymentInvoiceModel.fromUserModel(
        user: user!, priceInCent: priceInCent);

    final response = (await Navigator.pushNamed(context, PaymentScreen.id,
        arguments: paymentInvoice)) as PaymentResponse?;

    if (response != null && context.mounted) {
      if (response.state == true) {
        _choosenMethod = PaymentMethod.creditCard;
        transactionId = response.transactionId ?? "";
        await orderExecute(context);
      } else {
        showFailedAwesomeDialog(
            title: S.of(context).transactionFailed,
            desc:
                S.of(context).yourPaymentFailedToProcess,
            context: context);
      }
    }
  }

  Future<void> orderExecute(BuildContext context) async {
    showLoadingDIalog(context);
    final addresses = getAllAddresses(context);
    while (orderId == null) {
      await Future.delayed(const Duration(milliseconds: 200));
    }

    // ignore: use_build_context_synchronously
    final order = getOrderModel(addresses: addresses, context: context);

    final response =
        await ordersServices.makeOrder(order: order, orderItems: orderItems);
    if (response == DataResponse.success && context.mounted) {
      await BlocProvider.of<CartCubit>(context).clearCartCheckout();
      successOrder = order;
      nextStep();
    } else {
      if (context.mounted) {
        showErrorSnackBar(context);
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  OrderModel getOrderModel(
      {required List<AddressModel> addresses, required BuildContext context}) {
    AddressModel address =
        addresses.firstWhere((element) => element.id == choosenAddress);

    return OrderModel(
      id: orderId!,
      totalPrice: totalPrice,
      itemsCount: orderItemsCount,
      paymentMethod: _choosenMethod!,
      transactionId: transactionId,
      address: address,
      steps: [setNowDate(context)],
    );
  }

  List<AddressModel> getAllAddresses(context) =>
      BlocProvider.of<AddressesCubit>(context).addresses;

  @override
  void emit(CheckoutState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
