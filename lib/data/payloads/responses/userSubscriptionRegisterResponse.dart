class UsersubscriptionregisterResponse {
  String id;
  String accountId;
  String subscriptionId;
  DateTime startDate;
  DateTime endDate;
  String status;

  UsersubscriptionregisterResponse(
      {required this.id,
      required this.accountId,
      required this.subscriptionId,
      required this.startDate,
      required this.endDate,
      required this.status});

  factory UsersubscriptionregisterResponse.fromJson(Map<String, dynamic> json) {
    return UsersubscriptionregisterResponse(
        id: json['id'].toString(),
        accountId: json['accountId'].toString(),
        subscriptionId: json['subscriptionId'].toString(),
        startDate: DateTime.parse(json['startDate'] ?? ""), // Parse từ String
        endDate: DateTime.parse(json['endDate'] ?? ""),
        status: json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "accountId": accountId,
      "subscriptionId": subscriptionId,
      "startDate": startDate,
      "endDate": endDate,
      "status": status,
    };
  }
}
