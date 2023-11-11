part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentPageLoading extends PaymentState {}

final class PaymentPageSuccess extends PaymentState {}

final class PaymentPageFailure extends PaymentState {}

final class PaymentPageDoneTransaction extends PaymentState {
 final PaymentResponse paymentResponse;

  PaymentPageDoneTransaction({required this.paymentResponse});
}
