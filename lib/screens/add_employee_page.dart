import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final nameCtrl = TextEditingController();
  final salaryCtrl = TextEditingController();
  final service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Employee")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Employee Name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: salaryCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Per Day Salary",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Add Employee"),
              onPressed: () async {
                await service.addEmployee(
                  name: nameCtrl.text.trim(),
                  perDaySalary: int.parse(salaryCtrl.text.trim()),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
