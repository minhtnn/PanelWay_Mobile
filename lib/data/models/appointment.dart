import 'package:uuid/uuid.dart';

class Appointment{
  Uuid? id;
  String? code;
  DateTime? bookingDate;
  String? place;
  int? priority;
  String? status;
  Uuid? adContentId;
  Uuid? rentalLocationId;

  Appointment({
    this.id,
    this.code,
    this.bookingDate,
    this.place,
    this.priority,
    this.status,
    this.adContentId,
    this.rentalLocationId
  });

  factory Appointment.fromJson(Map<String, dynamic> json){
    return Appointment(
      id : json['id'],
      code: json['code'],
      bookingDate: json['bookingDate'],
      place: json['place'],
      priority: json['priority'],
      status: json['status'],
      adContentId: json['adContentId'],
      rentalLocationId: json['rentalLocationId']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "code" : code,
      "bookingDate" : bookingDate,
      "place" : place,
      "priority" : priority,
      "status" : status,
      "adContentId" : adContentId,
      "rentalLocationId" : rentalLocationId
    };
  }
}