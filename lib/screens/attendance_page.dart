import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../services/firestore_service.dart';

class AttendancePage extends StatefulWidget {
  final String empId;
  final String empName;

  const AttendancePage({
    super.key,
    required this.empId,
    required this.empName,
  });

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime selectedDay = DateTime.now();
  final service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDay);

    return Scaffold(
      appBar: AppBar(title: Text(widget.empName)),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: selectedDay,
            selectedDayPredicate: (day) =>
                isSameDay(day, selectedDay),
            onDaySelected: (day, _) {
              setState(() => selectedDay = day);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text("Mark Present"),
            onPressed: () async {
              await service.markAttendance(
                widget.empId,
                dateStr,
                true,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Present on $dateStr")),
              );
            },
          ),
          ElevatedButton(
            child: const Text("Mark Absent"),
            onPressed: () async {
              await service.markAttendance(
                widget.empId,
                dateStr,
                false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Absent on $dateStr")),
              );
            },
          ),
        ],
      ),
    );
  }
}
