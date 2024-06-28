class TypeListResponse {
  final List<int> feartured;
  final List<int> hot;

  TypeListResponse({required this.feartured, required this.hot});

  factory TypeListResponse.fromJson(Map<String, dynamic> json) {
    return TypeListResponse(
      feartured: List<int>.from(json['feartured']),
      hot: List<int>.from(json['hot']),
    );
  }
}
