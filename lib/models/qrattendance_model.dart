class QrResponseModel {
  final String message;

  QrResponseModel({required this.message});

  factory QrResponseModel.fromJson(Map<String, dynamic> json) {
    return QrResponseModel(
      message: json['message'] ?? 'Unknown error occurred',
    );
  }
}
