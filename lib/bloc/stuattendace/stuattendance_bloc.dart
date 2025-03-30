import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_event.dart';
import 'package:pc/bloc/stuattendace/stuattendance_state.dart';
import 'package:pc/repository/stuattendance_repository.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository repository;

  AttendanceBloc({required this.repository}) : super(AttendanceInitial()) {
    on<MarkAttendanceEvent>(_onMarkAttendance);
  }
  //hello my friend

  Future<void> _onMarkAttendance(
    MarkAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());

    final statusCode = await repository.markAttendance(event.studentNo);

    if (statusCode == 200) {
      emit(SnackBarSuccess(message: "✅ Attendance marked successfully!"));
    } else if (statusCode == 403) {
      emit(AttendanceFailure(error: "❌ Fees not paid, attendance not marked."));
    } else if (statusCode == 400) {
      emit(AttendanceFailure(error: "❌ Participant not found."));
    } else {
      emit(AttendanceFailure(error: "⚠️ Something went wrong!"));
    }
  }
}
