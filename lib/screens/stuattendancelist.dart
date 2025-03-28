import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_state.dart';

class AttendanceListScreen extends StatelessWidget {
  const AttendanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance List'),
        foregroundColor: Colors.redAccent,
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceListLoaded) {
            final attendanceList = state.attendanceList;
            return attendanceList.isEmpty
                ? const Center(child: Text('No attendance marked yet.'))
                : ListView.builder(
                  itemCount: attendanceList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      title: Text(
                        'Student No: ${attendanceList[index].studentNo}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                );
          } else {
            return const Center(child: Text('Error fetching attendance list.'));
          }
        },
      ),
    );
  }
}
