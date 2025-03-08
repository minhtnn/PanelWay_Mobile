class RentalLocationImage {
  String? id;
  String? imageUrl;
  String? description;
  bool? isDaylight;
  String? rentalLocationId;

  RentalLocationImage(
      {this.id,
      this.imageUrl,
      this.description,
      this.isDaylight,
      this.rentalLocationId});

  factory RentalLocationImage.fromJson(Map<String, dynamic> json) {
    return RentalLocationImage(
        id: json['id'].toString(),
        imageUrl: json['imageUrl'],
        description: json['description'],
        isDaylight: json['isDaylight'],
        rentalLocationId: json['rentalLocationId']);
  }
}
