import 'package:uuid/uuid.dart';

class AppointmentHistory{
  Uuid? id ;
  DateTime? issueDate ;
  String? fromStatus ;
  String? toStatus ;
  Uuid? advertisingClientId ;
  Uuid? spaceProviderId ;
  Uuid? appointmentId ;

  AppointmentHistory({
    this.id,
    this.issueDate,
    this.fromStatus,
    this.toStatus,
    this.advertisingClientId,
    this.spaceProviderId,
    this.appointmentId
  });

  factory AppointmentHistory.fromJson(Map<String, dynamic> json){
    return AppointmentHistory(
      id : json['id'],
      issueDate : json['issueDate'],
      fromStatus : json['fromStatus'],
      toStatus : json['toStatus'],
      advertisingClientId : json['advertisingClientId'],
      spaceProviderId : json['spaceProviderId'],
      appointmentId : json['appointmentId']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "issueDate" : issueDate,
      "fromStatus" : fromStatus,
      "toStatus" : toStatus,
      "advertisingClientId" : advertisingClientId,
      "spaceProviderId" : spaceProviderId,
      "appointmentId" : appointmentId
    };
  }
}