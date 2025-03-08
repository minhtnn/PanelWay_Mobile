import 'package:uuid/uuid.dart';

class RegulatoryLicense{
  Uuid? id;
  String? imgUrl;
  Uuid? regulatoryApprovalId;

  RegulatoryLicense({
    this.id,
    this.imgUrl,
    this.regulatoryApprovalId
  });

  factory RegulatoryLicense.fromJson(Map<String, dynamic> json){
    return RegulatoryLicense(
      id : json['id'],
      imgUrl: json['imgUrl'],
      regulatoryApprovalId: json['regulatoryApprovalId']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "imgUrl" : imgUrl,
      "regulatoryApprovalId" : regulatoryApprovalId
    };
  }
}