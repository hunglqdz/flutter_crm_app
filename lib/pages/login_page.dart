import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_crm_app/home_page.dart';
import 'package:flutter_crm_app/widgets/my_button.dart';
import 'package:flutter_crm_app/widgets/my_textfield.dart';

import '../auth/auth_service.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome back",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
              MyTextField(
                hint: "Enter Email",
                label: "Email",
                icon: Icons.email,
                controller: _email,
              ),
              const SizedBox(height: 20),
              MyTextField(
                hint: "Enter Password",
                label: "Password",
                icon: Icons.lock,
                controller: _password,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  MyButton(
                    label: "Login",
                    onPressed: _login,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("First-time user?"),
                  TextButton(
                    onPressed: () => goToSignup(context),
                    child: const Text("Sign Up",
                        style: TextStyle(color: Colors.blue, fontSize: 20)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpPage()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

  _login() async {
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log("User Logged In");
      goToHome(context);
    }
  }
}
