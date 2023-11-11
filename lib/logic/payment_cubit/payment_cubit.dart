import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/data/models/payment_invoice_model.dart';
import 'package:grocery_app/data/services/payment_services.dart';
import 'package:grocery_app/helper/objects.dart';
import 'package:meta/meta.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.paymentInvoice}) : super(PaymentInitial());

  final WebViewController controller = WebViewController();

  final PaymentInvoiceModel paymentInvoice;

  Future<void> init() async {
    emit(PaymentPageLoading());
    final paymentServices = PaymentServices(paymentInvoice: paymentInvoice);
    try {
      final String paymentToken = await paymentServices.createPaymentToken();

      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);

      await controller.loadRequest(Uri.parse("$kPaymobIframeUrl$paymentToken"));

      controller.setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          emit(PaymentPageSuccess());
        },
        onUrlChange: (change) {
          Uri uri = Uri.parse(change.url!);
          if (uri.pathSegments.last == "post_pay") {
            emit(PaymentPageDoneTransaction(
                paymentResponse: PaymentResponse(
                    transactionId: uri.queryParameters['id'],
                    state: uri.queryParameters['success'])));
          }
        },
      ));
    } catch (_) {
      emit(PaymentPageFailure());
    }
  }

  @override
  void emit(PaymentState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
