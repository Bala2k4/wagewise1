import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class SalaryPage extends StatelessWidget {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text("Salary Report")),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getEmployees(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final salary =
                  data['perDaySalary'] * data['presentDays'];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(data['name']),
                  subtitle: Text(
                    "Total Salary: ₹$salary",
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
