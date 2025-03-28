import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_event.dart';
import 'package:pc/bloc/stuattendace/stuattendance_state.dart';
import 'package:pc/screens/stuattendancelist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  // Dispatch Mark Attendance Event
  void _markAttendance(BuildContext context) {
    final studentNo = _controller.text.trim();
    if (studentNo.isEmpty) {
      _showSnackbar('Please enter a valid student number');
    } else {
      context.read<AttendanceBloc>().add(MarkAttendance(studentNo));
      _controller.clear(); // Clear text field after submission
    }
  }

  // Navigate to Attendance List Screen
  void _showAttendanceList(BuildContext context) {
    context.read<AttendanceBloc>().add(FetchAttendanceList());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AttendanceListScreen()),
    );
  }

  // Function to show Snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Include Attendance'),
        foregroundColor: Colors.redAccent,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField to enter student number
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Student Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Mark Attendance Button,
            BlocConsumer<AttendanceBloc, AttendanceState>(
              listener: (context, state) {
                if (state is AttendanceMarkedSuccess) {
                  _showSnackbar('Attendance marked successfully!');
                } else if (state is AttendanceMarkedFailure) {
                  _showSnackbar('failed to mark attendance');
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () => _markAttendance(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Mark Attendance',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Show Attendance Button
            ElevatedButton(
              onPressed: () => _showAttendanceList(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text(
                'Show Attendance',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
