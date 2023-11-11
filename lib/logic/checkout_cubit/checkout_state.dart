part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutChangeStep extends CheckoutState {}
final class CheckoutChangePaymentMethod extends CheckoutState {}
