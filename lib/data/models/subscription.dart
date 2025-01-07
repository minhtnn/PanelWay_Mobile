import 'package:uuid/uuid.dart';

class Subscription{
  Uuid? id;
  String? code;
  String? name;
  double? price;
  String? features;
  String? status;
  int? duration;

  Subscription({
    this.id,
    this.code,
    this.name,
    this.price,
    this.features,
    this.status,
    this.duration
  });

  factory Subscription.fromJson(Map<String, dynamic> json){
    return Subscription(
      id : json['id'],
      code : json['code'],
      name : json['name'],
      price : json['price'],
      features : json['features'],
      status : json['status'],
      duration : json['duration']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "code" : code,
      "name" : name,
      "price" : price,
      "features" : features,
      "status" : status,
      "duration" : duration
    };
  }
}