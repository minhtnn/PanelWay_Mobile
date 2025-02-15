import 'package:uuid/uuid.dart';

class RegulatoryApproval{
  Uuid? id;
  String? permitNumber;
  String? issueBy;
  DateTime? issueDate;
  DateTime? expirationDate;
  Uuid? rentalLocationId;

  RegulatoryApproval({
    this.id,
    this.permitNumber,
    this.issueBy,
    this.issueDate,
    this.expirationDate,
    this.rentalLocationId
  });

  factory RegulatoryApproval.fromJson(Map<String, dynamic> json){
    return RegulatoryApproval(
      id : json['id'],
      permitNumber : json['permitNumber'],
      issueBy : json['issueBy'],
      issueDate : json['issueDate'],
      expirationDate : json['expirationDate'],
      rentalLocationId : json['rentalLocationId']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "permitNumber" : permitNumber,
      "issueBy" : issueBy,
      "issueDate" : issueDate,
      "expirationDate" : expirationDate,
      "rentalLocationId" : rentalLocationId
    };
  }
}