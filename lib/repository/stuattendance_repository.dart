import 'package:dio/dio.dart';

class AttendanceRepository {
  final Dio _dio = Dio();

  Future<int> markAttendance(String studentNo) async {
    try {
      final response = await _dio.post(
        'https://api.programming-club.tech/api/present/',
        data: {'student_no': studentNo},
      );

      // ✅ Return the exact status code from response
      return response.statusCode ?? 400;
    } on DioException catch (e) {
      // ❌ Handle Dio errors and return 400 for API failure
      if (e.response != null) {
        return e.response?.statusCode ?? 400;
      }
      return 400; // Default error status if no response
    } catch (e) {
      return 400;
    }
  }
}
