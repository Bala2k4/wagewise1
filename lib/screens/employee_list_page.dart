import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text("Employees")),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getEmployees(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: snapshot.data!.docs.map((doc) {
              final salary = doc['perDaySalary'] * doc['totalPresentDays'];

              return Card(
                child: ListTile(
                  title: Text(doc['name']),
                  subtitle: Text(
                    "₹${doc['perDaySalary']} / day\nPresent Days: ${doc['totalPresentDays']}\nSalary: ₹$salary",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      await service.markPresent(doc.id);
                    },
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
