import 'package:panelway_mobile/data/models/rental_location_image.dart';

class RentalLocation {
  String? id;
  String? code;
  double? latitude;
  double? longitude;
  String? address;
  String? panelSize;
  String? description;
  String? postDate;
  String? availableDate;
  String? price;
  String? status;
  String? spaceProviderId;
  String? managerId;
  List<RentalLocationImage>? rentalLocationImages;

  RentalLocation({
    this.id,
    this.code,
    this.latitude,
    this.longitude,
    this.address,
    this.panelSize,
    this.description,
    this.postDate,
    this.availableDate,
    this.price,
    this.status,
    this.spaceProviderId,
    this.managerId,
    this.rentalLocationImages
  });

  factory RentalLocation.fromJson(Map<String, dynamic> json) {
    return RentalLocation(
      id: json['id']?.toString(),
      code: json['code'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      panelSize: json['panelSize'],
      description: json['description'],
      postDate: json['postDate'],
      availableDate: json['availableDate'] ,
      price: json["price"]?.toString(), // 🔥 Fix lỗi ép kiểu price
      status: json['status'],
      spaceProviderId: json['spaceProviderId'],
      managerId: json['managerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "panelSize": panelSize,
      "description": description,
      "postDate": postDate,
      "availableDate": availableDate,
      "price": price,
      "status": status,
      "spaceProviderId": spaceProviderId,
      "managerId": managerId,
    };
  }
}
