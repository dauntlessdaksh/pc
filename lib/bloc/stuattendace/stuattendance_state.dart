import 'package:equatable/equatable.dart';
import 'package:pc/models/stuattendance_model.dart';

abstract class AttendanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial State
class AttendanceInitial extends AttendanceState {}

// Loading State
class AttendanceLoading extends AttendanceState {}

// Success State
class AttendanceMarkedSuccess extends AttendanceState {}

// Failure State
class AttendanceMarkedFailure extends AttendanceState {}

// Attendance List Loaded State
class AttendanceListLoaded extends AttendanceState {
  final List<AttendanceModel> attendanceList;

  AttendanceListLoaded(this.attendanceList);

  @override
  List<Object?> get props => [attendanceList];
}
