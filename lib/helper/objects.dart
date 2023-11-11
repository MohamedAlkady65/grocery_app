class PaymentResponse {
  String? transactionId;
  bool? state;

  PaymentResponse({required  this.transactionId, String? state}) {
    this.state = state == "true";
  }
}
