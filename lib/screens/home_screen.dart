import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pc/bloc/stuattendace/stuattendance_bloc.dart';
import 'package:pc/bloc/stuattendace/stuattendance_event.dart';
import 'package:pc/bloc/stuattendace/stuattendance_state.dart';
import 'package:pc/screens/attendance_by_date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _studentController = TextEditingController();
  final ImagePicker _picker = ImagePicker(); // ✅ For QR Code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 🌑 Dark Background
      appBar: AppBar(
        title: const Text(
          "Attendance App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ✅ Styled TextField
            TextField(
              controller: _studentController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter Student Number',
                labelStyle: const TextStyle(color: Colors.redAccent),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Mark Attendance Button
            ElevatedButton.icon(
              onPressed: () {
                final studentNo = _studentController.text.trim();
                if (studentNo.isNotEmpty) {
                  context.read<AttendanceBloc>().add(
                    MarkAttendanceEvent(studentNo: studentNo),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid student number!"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check, color: Colors.white),
              label: const Text(
                'Mark Attendance',
                style: TextStyle(
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

            // ✅ Show Attendance by Date Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AttendanceByDateScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.date_range, color: Colors.white),
              label: const Text(
                'Show Attendance by Date',
                style: TextStyle(
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

            // ✅ BlocListener for Attendance API
            Expanded(
              child: BlocListener<AttendanceBloc, AttendanceState>(
                listener: (context, state) {
                  if (state is AttendanceFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is SnackBarSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    "Enter Student Number and Click 'Mark Attendance'",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),

            // ✅ BlocListener for QR Upload API
          ],
        ),
      ),
    );
  }
}
