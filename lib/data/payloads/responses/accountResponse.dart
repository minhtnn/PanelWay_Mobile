class AccountResponse {
  String? avatarUrl;
  String? fullName;
  String? gender;
  String? email;
  String? phoneNumber;

  AccountResponse(
      {required this.avatarUrl,
      required this.fullName,
      required this.email,
      required this.gender,
      required this.phoneNumber});

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
        avatarUrl: json['avatarUrl'],
        fullName: json['fullName'],
        email: json['email'],
        gender: json['gender'],
        phoneNumber: json['phoneNumber']);
  }
  Map<String, dynamic> toJson() {
    return {
      "avatarUrl": avatarUrl,
      "fullName": fullName,
      "email": email,
      "gender": gender,
      'phoneNumber': phoneNumber
    };
  }
}
