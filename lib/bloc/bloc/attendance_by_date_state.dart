import 'package:equatable/equatable.dart';
import 'package:pc/models/attendancebydate.dart';

// ✅ Abstract State Class
abstract class AttendanceByDateState extends Equatable {
  const AttendanceByDateState();

  @override
  List<Object?> get props => [];
}

// ✅ Initial State
class AttendanceByDateInitial extends AttendanceByDateState {
  const AttendanceByDateInitial();
}

// ✅ Loading State
class AttendanceByDateLoading extends AttendanceByDateState {
  const AttendanceByDateLoading();
}

// ✅ Success State with List of Students
class AttendanceByDateSuccess extends AttendanceByDateState {
  final List<AttendanceByDate> attendanceList;

  const AttendanceByDateSuccess(this.attendanceList);

  @override
  List<Object?> get props => [attendanceList];
}

// ✅ Failure State
class AttendanceByDateFailure extends AttendanceByDateState {
  final String error;

  const AttendanceByDateFailure(this.error);

  @override
  List<Object?> get props => [error];
}
