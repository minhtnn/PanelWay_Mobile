
class Subscription{
  String? id;
  String? code;
  String? name;
  String? price;
  String? features;
  String? status;
  String? duration;
  int? priorty;

  Subscription({
    this.id,
    this.code,
    this.name,
    this.price,
    this.features,
    this.status,
    this.duration,
    this.priorty
  });

  factory Subscription.fromJson(Map<String, dynamic> json){
    return Subscription(
      id : json['id'].toString(),
      code : json['code'].toString(),
      name : json['name'].toString(),
      price : json['price'].toString(),
      features : json['features'].toString(),
      status : json['status'].toString(),
      duration : json['duration'].toString(),
      priorty: json['priority']??0
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "code" : code,
      "name" : name,
      "price" : price,
      "features" : features,
      "status" : status,
      "duration" : duration,
      "priority" : priorty
    };
  }
}