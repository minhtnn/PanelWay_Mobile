import 'package:uuid/uuid.dart';

class PanelType {
  Uuid? id;
  String? name;
  String? description;

  PanelType({
      id,
    this.name,
    this.description
  });

  factory PanelType.fromJson(Map<String, dynamic> json){
    return PanelType(
      id : json['id'],
      name: json['name'],
      description : json['description']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "name" : name,
      "description" : description
    };
  }
}
