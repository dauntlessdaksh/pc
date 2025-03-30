import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/bloc/attendance_by_date_event.dart';
import 'package:pc/bloc/bloc/attendance_by_date_state.dart';
import 'package:pc/models/attendancebydate.dart';
import 'package:pc/repository/attendance_by_date_repository.dart';

class AttendanceByDateBloc
    extends Bloc<AttendanceByDateEvent, AttendanceByDateState> {
  final AttendanceByDateRepository repository;

  AttendanceByDateBloc({required this.repository})
    : super(const AttendanceByDateInitial()) {
    on<FetchAttendanceByDateEvent>(_onFetchAttendanceByDate);
  }

  Future<void> _onFetchAttendanceByDate(
    FetchAttendanceByDateEvent event,
    Emitter<AttendanceByDateState> emit,
  ) async {
    emit(const AttendanceByDateLoading());

    try {
      final List<AttendanceByDate> attendanceList = await repository
          .fetchAttendanceByDate(event.date);
      emit(AttendanceByDateSuccess(attendanceList));
    } catch (e) {
      emit(AttendanceByDateFailure(e.toString()));
    }
  }
}
