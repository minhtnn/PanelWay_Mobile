import 'package:uuid/uuid.dart';

class PaymentType{
  Uuid? id;
  String? name;
  String? description;
  String? imgUrl;

  PaymentType({
    this.id,
    this.name,
    this.description,
    this.imgUrl
  });

  factory PaymentType.fromJson(Map<String, dynamic> json){
    return PaymentType(
      id : json['id'],
      name : json['name'],
      description : json['description'],
      imgUrl : json['imgUrl']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "name" : name,
      "description" : description,
      "imgUrl" : imgUrl
    };
  }
}