import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Mark attendance event
class MarkAttendance extends AttendanceEvent {
  final String studentNo;

  MarkAttendance(this.studentNo);

  @override
  List<Object?> get props => [studentNo];
}

// Fetch attendance list event
class FetchAttendanceList extends AttendanceEvent {}
