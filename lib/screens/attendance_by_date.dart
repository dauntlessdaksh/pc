import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pc/bloc/bloc/attendance_by_date_bloc.dart';
import 'package:pc/bloc/bloc/attendance_by_date_event.dart';
import 'package:pc/bloc/bloc/attendance_by_date_state.dart';

class AttendanceByDateScreen extends StatefulWidget {
  const AttendanceByDateScreen({super.key});

  @override
  State<AttendanceByDateScreen> createState() => _AttendanceByDateScreenState();
}

class _AttendanceByDateScreenState extends State<AttendanceByDateScreen> {
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 🌑 Dark background
      appBar: AppBar(
        title: const Text(
          "Attendance by Date",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ✅ Date Picker Button
            ElevatedButton.icon(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: Colors.redAccent,
                          onPrimary: Colors.black,
                          surface: Colors.black,
                          onSurface: Colors.white,
                        ),
                        dialogBackgroundColor: Colors.grey[900],
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
              icon: const Icon(Icons.date_range, color: Colors.white),
              label: Text(
                'Select Date: $selectedDate',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Button to Fetch Attendance
            ElevatedButton(
              onPressed: () {
                context.read<AttendanceByDateBloc>().add(
                  FetchAttendanceByDateEvent(selectedDate),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Fetch Attendance',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Display Attendance List or Error Message
            Expanded(
              child: BlocBuilder<AttendanceByDateBloc, AttendanceByDateState>(
                builder: (context, state) {
                  if (state is AttendanceByDateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AttendanceByDateSuccess) {
                    if (state.attendanceList.isEmpty) {
                      return const Center(
                        child: Text(
                          "No attendance data found for this date.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.attendanceList.length,
                      itemBuilder: (context, index) {
                        final student = state.attendanceList[index];
                        return Card(
                          elevation: 4,
                          color: Colors.grey[900], // Dark card
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Text(
                                '${index + 1}', // ✅ Serial Number
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              "Student No: ${student.studentNo}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "Name: ${student.studentName}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                            ),
                            trailing: const Icon(
                              Icons.check_circle,
                              color: Colors.greenAccent,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is AttendanceByDateFailure) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "Select a date to fetch attendance.",
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
