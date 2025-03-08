class PaginatedResponse<T> {
  final List<T> items;
  final String totalCount;
  final String pageIndex;
  final String pageSize;
  final String totalPages;

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
      totalCount: json['total'].toString(),
      pageIndex: json['page'].toString(),
      pageSize: json['size'].toString(),
      totalPages: json['totalPages'].toString(),
    );
  }
    Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'items': items.map((item) => toJsonT(item)).toList(),
      'total': totalCount.toString(),
      'page': pageIndex.toString(),
      'size': pageSize.toString(),
      'totalPages': totalPages.toString(),
    };
  }

}