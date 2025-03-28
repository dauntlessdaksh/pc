import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final String studentNumber;

  const StudentTile({super.key, required this.studentNumber});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text('Student No: $studentNumber'),
    );
  }
}
