class Account {
  String? accessToken;
  String? id;
  String? avatarUrl;
  String? accountStatus;
  String? role;
  String? individualPoint;
  String? userId;

  //User
  String? fullName;
  String? gender;
  String? email;
  String? phoneNumber;
  String? username;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userStatus;
  bool? verificationStatus;

  Account(
      {this.accessToken,
      this.id,
      this.avatarUrl,
      this.accountStatus,
      this.role,
      this.individualPoint,
      this.userId,
      this.fullName,
      this.gender,
      this.email,
      this.phoneNumber,
      this.username,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.userStatus,
      this.verificationStatus});

  factory Account.fromJson(Map<String, dynamic> json) {
    final accountResponse = json['accountResponse'] ?? {};
    return Account(
        accessToken: json['jwtToken'],
        id: accountResponse['id'].toString(),
        avatarUrl: accountResponse['avatarUrl'],
        accountStatus: accountResponse['status'],
        role: accountResponse['role'],
        individualPoint: accountResponse['individualPoint'].toString(),
        userId: accountResponse['userId'],
        fullName: accountResponse['fullName'],
        gender: accountResponse['gender'],
        email: accountResponse['email'],
        phoneNumber: accountResponse['phoneNumber'],
        username: accountResponse['userName'],
        password: accountResponse['password'],
        createdAt: DateTime.tryParse(accountResponse['createdAt'] ?? ''),
        updatedAt: DateTime.tryParse(accountResponse['updatedAt'] ?? ''),
        userStatus: accountResponse['userStatus'],
        verificationStatus: accountResponse['verificationStatus']);
  }

  factory Account.fromJson2(Map<String, dynamic> json) {
  return Account(
    accessToken: json['jwtToken'],
    id: json['id'],  // Kiểm tra xem có đúng key không
    avatarUrl: json['avatarUrl'],
    accountStatus: json['accountStatus'],
    role: json['role'],
    individualPoint: json['individualPoint'],
    userId: json['userId'],
    fullName: json['fullName'],
    gender: json['gender'],
    email: json['email'],
    phoneNumber: json['phoneNumber'],
    username: json['username'],
    password: json['password'],
    createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
    updatedAt: DateTime.tryParse(json['createdAt'] ?? ''),
    verificationStatus: json['verificationStatus'],
  );
}


  Map<String, dynamic> toJson() {
    return {
      "jwtToken": accessToken,
      "id": id,
      "avatarUrl": avatarUrl,
      "accountStatus": accountStatus,
      "role": role,
      "individualPoint": individualPoint,
      "userId": userId,
      "fullName": fullName,
      "gender": gender,
      "email": email,
      "phoneNumber": phoneNumber,
      "username": username,
      "password": password,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
      // "userStatus": userStatus,
      "verificationStatus": verificationStatus
    };
  }
}
