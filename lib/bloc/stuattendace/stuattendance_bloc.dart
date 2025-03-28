import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_event.dart';
import 'package:pc/bloc/stuattendace/stuattendance_state.dart';
import 'package:pc/repository/stuattendance_repository.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository repository;

  AttendanceBloc(this.repository) : super(AttendanceInitial()) {
    // Mark attendance event
    on<MarkAttendance>((event, emit) async {
      emit(AttendanceLoading());
      try {
        await repository.markAttendance(event.studentNo);
        emit(AttendanceMarkedSuccess());
      } catch (e) {
        emit(AttendanceMarkedFailure());
      }
    });

    // Fetch attendance list event
    on<FetchAttendanceList>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final attendanceList = await repository.getAttendanceList();
        emit(AttendanceListLoaded(attendanceList));
      } catch (e) {
        emit(AttendanceMarkedFailure());
      }
    });
  }
}
