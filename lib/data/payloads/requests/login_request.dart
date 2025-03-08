class LoginRequest {
  String phoneNumber;
  String password;
  String role;
  LoginRequest(
      {required this.phoneNumber, required this.password, required this.role});
  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber, "password": password, "role": role};
  }
}
