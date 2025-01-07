import 'package:uuid/uuid.dart';

class UserSubscription{
  Uuid? id;
  Uuid? accountId;
  Uuid? subscriptionId;
  DateTime? startDate;
  DateTime? endDate;
  String? status;

  UserSubscription({
    this.id,
    this.accountId,
    this.subscriptionId,
    this.startDate,
    this.endDate,
    this.status
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json){
    return UserSubscription(
      id : json['id'],
      accountId : json['accountId'],
      subscriptionId : json['subscriptionId'],
      startDate : json['startDate'],
      endDate : json['endDate'],
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