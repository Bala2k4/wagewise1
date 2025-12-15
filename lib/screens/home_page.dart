import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'employee_list_page.dart';
import 'salary_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text("Logout"),
                      onPressed: () async {
                        await auth.logout();
                        Navigator.popUntil(context, (r) => r.isFirst);
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Attendance"),
            trailing: const Icon(Icons.calendar_month),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EmployeeListPage()),
            ),
          ),
          ListTile(
            title: const Text("Salary Report"),
            trailing: const Icon(Icons.payments),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SalaryPage()),
            ),
          ),
        ],
      ),
    );
  }
}
    