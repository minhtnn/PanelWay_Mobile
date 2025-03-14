import 'package:panelway_mobile/data/models/subscription.dart';

class UserSubscription{
  String? id;
  String? accountId;
  String? subscriptionId;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  Subscription? subscription;

  UserSubscription({
    this.id,
    this.accountId,
    this.subscriptionId,
    this.startDate,
    this.endDate,
    this.status,
    this.subscription
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json){
    return UserSubscription(
      id : json['id'],
      accountId : json['accountId'],
      subscriptionId : json['subscriptionId'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      status : json['status']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "accountId" : accountId,
      "subscriptionId" : subscriptionId,
      "startDate" : startDate,
      "endDate" : endDate,
      "status" : status
    };
  }
}