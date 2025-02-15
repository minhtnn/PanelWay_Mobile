import 'package:uuid/uuid.dart';

class Payment{
  Uuid? id;
  Uuid? paymentTypeId;
  String? details;
  String? status;
  DateTime? createdAt;

  Payment({
    this.id,
    this.paymentTypeId,
    this.details,
    this.status,
    this.createdAt
  });

  factory Payment.fromJson(Map<String, dynamic> json){
    return Payment(
      id : json['id'],
      paymentTypeId : json["paymentTypeId"],
      details : json['details'],
      status : json['status'],
      createdAt : json['createdAt']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "paymentTypeId" : paymentTypeId,
      "details" : details,
      "status" : status,
      "createdAt" : createdAt
    };
  }
}