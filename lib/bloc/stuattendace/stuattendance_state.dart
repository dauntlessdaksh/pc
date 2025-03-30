import 'package:equatable/equatable.dart';

abstract class AttendanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceFailure extends AttendanceState {
  final String error;

  AttendanceFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// ✅ Only showing a success message now, no student list
class SnackBarSuccess extends AttendanceState {
  final String message;

  SnackBarSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
