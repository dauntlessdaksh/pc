import 'package:dio/dio.dart';
import 'package:pc/models/stuattendance_model.dart';

class AttendanceRepository {
  final Dio _dio = Dio();
  final String apiUrl = 'http://13.200.54.180/api/present/';

  // MARK ATTENDANCE - POST Request
  Future<void> markAttendance(String studentNo) async {
    try {
      final response = await _dio.post(apiUrl, data: {'student_no': studentNo});

      if (response.statusCode != 200) {
        throw Exception('Failed to mark attendance');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // FETCH ATTENDANCE LIST - Mocked Data (Replace with API if needed)
  Future<List<AttendanceModel>> getAttendanceList() async {
    // Mock API response - Replace with actual API response when ready
    List<Map<String, dynamic>> mockData = [
      {"student_no": "23153016"},
      {"student_no": "23153017"},
      {"student_no": "23153018"},
    ];

    // Convert mockData to List of AttendanceModel objects
    return mockData.map((e) => AttendanceModel.fromJson(e)).toList();
  }
}
