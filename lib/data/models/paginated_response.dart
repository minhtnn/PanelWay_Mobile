class PaginatedResponse<T> {
  final List<T> items;
  final int totalCount;
  final int pageIndex;
  final int pageSize;
  final int totalPages;

  PaginatedResponse({
    required this.items,
    required this.totalCount,
    required this.pageIndex,
    required this.pageSize,
    required this.totalPages,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT, // Function để convert object
  ) {
    return PaginatedResponse(
      items: (json['items'] as List).map((item) => fromJsonT(item)).toList(),
      totalCount: json['total'],
      pageIndex: json['page'],
      pageSize: json['size'],
      totalPages: json['totalPages'],
    );
  }
    Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'items': items.map((item) => toJsonT(item)).toList(),
      'total': totalCount,
      'page': pageIndex,
      'size': pageSize,
      'totalPages': totalPages,
    };
  }

}