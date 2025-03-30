import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MarkAttendanceEvent extends AttendanceEvent {
  final String studentNo;

  MarkAttendanceEvent({required this.studentNo});

  @override
  List<Object?> get props => [studentNo];
}

class GetAttendanceListEvent extends AttendanceEvent {}
