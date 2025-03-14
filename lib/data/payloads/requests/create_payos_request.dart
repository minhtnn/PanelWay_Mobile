class CreatePayOsRequest {
  int amount;
  String description;
  String subscriptionName;
  int quantity;

  CreatePayOsRequest(
      {required this.amount,
      required this.description,
      required this.subscriptionName,
      required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "description": description,
      "items": [
        {"name": subscriptionName, "quantity": quantity, "price": amount}
      ],
      "returnUrl": "xxxxxx",
      "cancelUrl": "xxxxxx"
    };
  }
}
