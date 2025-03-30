class Student {
  final String studentNo;

  Student({required this.studentNo});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(studentNo: json['student_no']);
  }
}
