import 'dart:ui';

import 'package:uuid/uuid.dart';

class Account {
  String? accessToken;
  String? id;
  String? avatarUrl;
  String? accountStatus;
  String? role;
  int? individualPoint;
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
        id: accountResponse['id'],
        avatarUrl: accountResponse['avatarUrl'],
        accountStatus: accountResponse['status'],
        role: accountResponse['role'],
        individualPoint: accountResponse['individualPoint'],
        userId: accountResponse['userId'],
        fullName: accountResponse['fullName'],
        gender: accountResponse['gender'],
        email: accountResponse['email'],
        phoneNumber: accountResponse['phoneNumber'],
        username: accountResponse['username'],
        password: accountResponse['password'],
        createdAt: accountResponse['createdAt'],
        updatedAt: accountResponse['updatedAt'],
        userStatus: accountResponse['userStatus'],
        verificationStatus: accountResponse['verificationStatus']);
  }

  Map<String, dynamic> toJson(){
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
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        // "userStatus": userStatus,
        "verificationStatus": verificationStatus
    };
  }
}
