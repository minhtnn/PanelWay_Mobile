class UsersubscriptionregisterRequest {
  String accountId;
  String subscriptionId;
  DateTime startDate;

  UsersubscriptionregisterRequest(
      {required this.accountId,
      required this.subscriptionId,
      required this.startDate});

  Map<String, dynamic> toJson() {
    return {
      "accountId": accountId,
      "subscriptionId": subscriptionId,
      "startDate": startDate.toIso8601String()
    };
  }
}
