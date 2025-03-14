class PayosQrResponse {
  String bin;
  String accountNumber;
  String amount;
  String description;
  String orderCode;
  String currency;
  String paymentLinkId;
  String status;
  String expiredAt;
  String checkoutUrl;
  String qrCode;

  PayosQrResponse(
      {required this.bin,
      required this.accountNumber,
      required this.amount,
      required this.description,
      required this.orderCode,
      required this.currency,
      required this.paymentLinkId,
      required this.status,
      required this.expiredAt,
      required this.checkoutUrl,
      required this.qrCode});

  factory PayosQrResponse.fromJson(Map<String, dynamic> json) {
    return PayosQrResponse(
        bin: json['bin'].toString(),
        accountNumber: json['accountNumber'].toString(),
        amount: json['amount'].toString(),
        description: json['description'].toString(),
        orderCode: json['orderCode'].toString(),
        currency: json['currency'].toString(),
        paymentLinkId: json['paymentLinkId'].toString(),
        status: json['status'].toString(),
        expiredAt: json['expiredAt'].toString(),
        checkoutUrl: json['checkoutUrl'].toString(),
        qrCode: json['qrCode'].toString());
  }
  Map<String, dynamic> toJson() {
    return {
      "bin": bin,
      "accountNumber": accountNumber,
      "amount": amount,
      "description": description,
      "orderCode": orderCode,
      "currency": currency,
      "paymentLinkId": paymentLinkId,
      "status": status,
      "expiredAt": expiredAt,
      "checkoutUrl": checkoutUrl,
      "qrCode": qrCode
    };
  }
}
