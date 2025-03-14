class PayosCheckResponse {
  String id;
  int orderCode;
  int amount;
  int amountPaid;
  int amountRemaining;
  String status;
  DateTime createdAt;
  DateTime? canceledAt; // Sửa tên và cho phép null
  String? cancellationReason; // Cho phép null

  PayosCheckResponse({
    required this.id,
    required this.orderCode,
    required this.amount,
    required this.amountPaid,
    required this.amountRemaining,
    required this.status,
    required this.createdAt,
    this.canceledAt,
    this.cancellationReason,
  });

  factory PayosCheckResponse.fromJson(Map<String, dynamic> json) {
    return PayosCheckResponse(
      id: json['id'],
      orderCode: json['orderCode'],
      amount: json['amount'],
      amountPaid: json['amountPaid'],
      amountRemaining: json['amountRemaining'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']), // Parse từ String
      canceledAt: json['canceledAt'] != null ? DateTime.parse(json['canceledAt']) : null, // Xử lý null
      cancellationReason: json['cancellationReason'], // Có thể null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "orderCode": orderCode,
      "amount": amount,
      "amountPaid": amountPaid,
      "amountRemaining": amountRemaining,
      "status": status,
      "createdAt": createdAt.toIso8601String(), // Chuyển về String
      "canceledAt": canceledAt?.toIso8601String(), // Xử lý null
      "cancellationReason": cancellationReason, // Giữ nguyên null nếu có
    };
  }
}
