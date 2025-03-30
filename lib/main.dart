import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/bloc/attendance_by_date_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_bloc.dart';
import 'package:pc/repository/stuattendance_repository.dart';
import 'package:pc/repository/attendance_by_date_repository.dart';
import 'package:pc/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AttendanceRepository repository = AttendanceRepository();
  final AttendanceByDateRepository attendanceByDateRepository =
      AttendanceByDateRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttendanceBloc(repository: repository),
        ),
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
    );
  }
}
