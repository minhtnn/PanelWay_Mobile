import 'package:uuid/uuid.dart';

class AdContent {
  Uuid? id;
  String? code;
  String? type;
  String? content;
  String? size;
  String? imgUrl;
  Uuid? advertisingClientId;

  AdContent(
      {this.id,
      this.code,
      this.type,
      this.content,
      this.size,
      this.imgUrl,
      this.advertisingClientId});

  factory AdContent.fromJson(Map<String, dynamic> json) {
    return AdContent(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        content: json["content"],
        size: json["size"],
        imgUrl: json["imgUrl"],
        advertisingClientId: json["advertisingClientId"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "type": type,
      "content": content,
      "size": size,
      "imgUrl": imgUrl,
      "advertisingClientId": advertisingClientId
    };
  }
}
