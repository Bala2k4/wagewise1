import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();
  bool loading = false;

  void showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  setState(() => loading = true);
                  try {
                    await auth.login(
                      emailCtrl.text.trim(),
                      passCtrl.text.trim(),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  } catch (e) {
                    showError(e.toString());
                  }
                  setState(() => loading = false);
                },
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Login"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignupPage(),
                    ),
                  );
                },
                child: const Text("Create account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
