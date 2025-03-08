class RegisterRequest {
  String age;
  String fullName;
  String gender;
  String phoneNumber;
  String userName;
  String password;
  RegisterRequest(
      {required this.age,
      required this.fullName,
      required this.gender,
      required this.phoneNumber,
      required this.userName,
      required this.password});
  Map<String, dynamic> toJson() {
    return {
      "age": age.toString(),
      "fullName": fullName.toString(),
      "gender": gender.toString(),
      "phoneNumber": phoneNumber.toString(),
      "userName": userName.toString(),
      "password": password.toString()
    };
  }
}
