class OtpResponse {
  String? Status;
  String? Message;
  String? OtpCode;
  OtpResponse({this.Status, this.Message, this.OtpCode});
  Map<String, dynamic> toJson() {
    return {"status": Status, "message": Message, "otpCode": OtpCode};
  }
  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      Status: json['status']?.toString(),
      Message: json['message'],
      OtpCode: json['otpCode'],
    );
  }
}
