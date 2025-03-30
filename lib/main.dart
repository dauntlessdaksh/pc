import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/bloc/attendance_by_date_bloc.dart';
import 'package:pc/bloc/qrattendance/qrbloc_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_bloc.dart';
import 'package:pc/repository/attendance_by_date_repository.dart';
import 'package:pc/repository/qrattendance_repository.dart';
import 'package:pc/repository/stuattendance_repository.dart';
import 'package:pc/screens/home_screen.dart';

void main() {
  final AttendanceRepository attendanceRepository = AttendanceRepository();
  final QrRepository qrRepository = QrRepository();
  final AttendanceByDateRepository attendanceByDateRepository =
      AttendanceByDateRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttendanceBloc(repository: attendanceRepository),
        ),
        BlocProvider(create: (context) => QrBloc(repository: qrRepository)),
        BlocProvider(
          create:
              (context) =>
                  AttendanceByDateBloc(repository: attendanceByDateRepository),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
