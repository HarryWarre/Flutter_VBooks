class TypeListResponse {
  final List<String> feartured;
  final List<String> hot;

  TypeListResponse({required this.feartured, required this.hot});

  factory TypeListResponse.fromJson(Map<String, dynamic> json) {
    return TypeListResponse(
      feartured: List<String>.from(json['feartured']),
      hot: List<String>.from(json['hot']),
    );
  }
}
