class CreatePayOsRequest {
  int amount;
  String description;
  String subscriptionName;
  int quantity;
  String subcriptionId;
  String accountId;

  CreatePayOsRequest(
      {required this.amount,
      required this.description,
      required this.subscriptionName,
      required this.quantity,
      required this.subcriptionId,
      required this.accountId});

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "description": description,
      "items": [
        {"name": subscriptionName, "quantity": quantity, "price": amount}
      ],
      "returnUrl": "xxxxxx",
      "cancelUrl": "xxxxxx",
      "accountId": accountId,
      "subcriptionId": subcriptionId,
    };
  }
}
