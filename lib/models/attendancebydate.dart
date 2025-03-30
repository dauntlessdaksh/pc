class AttendanceByDate {
  final String studentNo;
  final String studentName;

  AttendanceByDate({required this.studentNo, required this.studentName});

  // ✅ Handle null values with default values
  factory AttendanceByDate.fromJson(Map<String, dynamic> json) {
    return AttendanceByDate(
      studentNo: json['participant__student_no']?.toString() ?? 'N/A',
      studentName:
          (json['participant__name'] != null &&
                  json['participant__name'].toString().trim().isNotEmpty)
              ? json['participant__name'].toString()
              : 'Unknown',
    );
  }
}
