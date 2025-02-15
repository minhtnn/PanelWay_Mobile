import 'package:uuid/uuid.dart';

class RentalLocationPanelType{
  Uuid? rentalLocationId;
  Uuid? panelTypeId;

  RentalLocationPanelType({
    this.rentalLocationId,
    this.panelTypeId
  });

  factory RentalLocationPanelType.fromJson(Map<String, dynamic> json){
    return RentalLocationPanelType(
      rentalLocationId : json['rentalLocationId'],
      panelTypeId : json['panelTypeId']
    );
  }
  Map<String, dynamic> toJson(){
    return {
      "rentalLocationId" : rentalLocationId,
      "panelTypeId" : panelTypeId
    };
  }
}