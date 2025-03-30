import 'package:equatable/equatable.dart';

abstract class AttendanceByDateEvent extends Equatable {
  const AttendanceByDateEvent();

  @override
  List<Object?> get props => [];
}

// ✅ Event to fetch attendance by date
class FetchAttendanceByDateEvent extends AttendanceByDateEvent {
  final String date;

  const FetchAttendanceByDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}
