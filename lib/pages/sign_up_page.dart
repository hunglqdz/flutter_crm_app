import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_crm_app/home_page.dart';
import 'package:flutter_crm_app/pages/login_page.dart';
import 'package:flutter_crm_app/widgets/my_button.dart';
import 'package:flutter_crm_app/widgets/my_textfield.dart';

import '../auth/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
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
              const Text("Create new account",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
              MyTextField(
                hint: "Enter Name",
                label: "Name",
                icon: Icons.abc,
                controller: _name,
              ),
              const SizedBox(height: 20),
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
                    label: "Sign Up",
                    onPressed: _signup,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => goToLogin(context),
                    child: const Text("Login",
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

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

  _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(
        _name.text, _email.text, _password.text);
    if (user != null) {
      log("User Created Successfully");
      goToHome(context);
    }
  }
}
