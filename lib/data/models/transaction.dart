import 'package:uuid/uuid.dart';

class Transaction{
  Uuid? id;
  Uuid? subscriptionId;
  Uuid? userSubscriptionId;
  Uuid? paymentId;
  double? amount;
  DateTime? transactionDate;
  String? status;

  Transaction({
    this.id,
    this.subscriptionId,
    this.userSubscriptionId,
    this.paymentId,
    this.amount,
    this.transactionDate,
    this.status
  });

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      id : json['id'],
      subscriptionId : json['subscriptionId'],
      userSubscriptionId : json['userSubscriptionId'],
      paymentId : json['paymentId'],
      amount : json['amount'],
      transactionDate : json['transactionDate'],
      status : json['status']
    );
  }
  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "subscriptionId" : subscriptionId,
      "userSubscriptionId" : userSubscriptionId,
      "paymentId" : paymentId,
      "amount" : amount,
      "transactionDate" : transactionDate,
      "status" : status
    };
  }
}