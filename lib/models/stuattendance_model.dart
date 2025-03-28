class AttendanceModel {
  final String studentNo;

  AttendanceModel({required this.studentNo});

  // Convert JSON to AttendanceModel
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(studentNo: json['student_no']);
  }

  // Convert AttendanceModel to JSON
  Map<String, dynamic> toJson() {
    return {'student_no': studentNo};
  }
}
