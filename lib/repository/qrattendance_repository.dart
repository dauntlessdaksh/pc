import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart'; // Add this line
import 'package:pc/models/qrattendance_model.dart';

class QrRepository {
  final Dio _dio = Dio();
  final String apiUrl = 'https://api.programming-club.tech/api/presentQr/';

  Future<QrResponseModel> uploadQrImage(XFile image) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          contentType: MediaType('image', 'png'), // Correct usage here
        ),
      });

      final response = await _dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        return QrResponseModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to upload QR. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error uploading QR: ${e.toString()}');
    }
  }
}
