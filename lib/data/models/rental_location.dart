import 'package:uuid/uuid.dart';

class RentalLocation{
  Uuid? id;
  String? code;
  double? locationX;
  double? locationY;
  String? address;
  String? panelSize;
  String? description;
  DateTime? postDate;
  DateTime? availableDate;
  double? price;
  String? status;
  Uuid? spaceProviderId;
  Uuid? managerId;

  RentalLocation({
    this.id, 
    this.code,
    this.locationX,
    this.locationY,
    this.address,
    this.panelSize,
    this.description,
    this.postDate,
    this.availableDate,
    this.price,
    this.status,
    this.spaceProviderId,
    this.managerId
  });

  factory RentalLocation.fromJson(Map<String, dynamic> json){
    return RentalLocation(
      id : json['id'], 
      code : json['code'],
      locationX : json['locationX'],
      locationY : json['locationY'],
      address : json['address'],
      panelSize : json['panelSize'],
      description : json['description'],
      postDate : json['postDate'],
      availableDate : json['availableDate'],
      price : json['price'],
      status : json['status'],
      spaceProviderId : json['spaceProviderId'],
      managerId : json['managerId']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id, 
      "code" : code,
      "locationX" : locationX,
      "locationY" : locationY,
      "address" : address,
      "panelSize" : panelSize,
      "description" : description,
      "postDate" : postDate,
      "availableDate" : availableDate,
      "price" : price,
      "status" : status,
      "spaceProviderId" : spaceProviderId,
      "managerId" : managerId
    };
  }
}