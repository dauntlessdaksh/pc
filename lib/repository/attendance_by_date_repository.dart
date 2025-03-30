import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pc/models/attendancebydate.dart';

class AttendanceByDateRepository {
  final Dio _dio = Dio();
  final String apiUrl = 'https://api.programming-club.tech/api/attendance/';

  Future<List<AttendanceByDate>> fetchAttendanceByDate(String date) async {
    try {
      final response = await _dio.get(apiUrl, queryParameters: {'date': date});

      if (response.statusCode == 200) {
        final List<dynamic>? data =
            response.data['attendance']; // ✅ Null Safety
        if (data != null) {
          return data.map((json) => AttendanceByDate.fromJson(json)).toList();
        } else {
          throw Exception('No attendance data found for this date');
        }
      } else {
        throw Exception('Data not present');
      }
    } catch (e) {
      throw Exception('Error fetching attendance: ${e.toString()}');
    }
  }
}
