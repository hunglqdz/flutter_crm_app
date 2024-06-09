import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_crm_app/home_page.dart';
import 'package:flutter_crm_app/pages/log_in_page.dart';
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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
              const Text("Create your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              MyTextField(
                label: "Name",
                icon: Icons.person,
                controller: nameController,
              ),
              const SizedBox(height: 20),
              MyTextField(
                label: "Email",
                icon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 20),
              MyTextField(
                label: "Password",
                icon: Icons.password,
                controller: passwordController,
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
                    child: const Text("Log In",
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
        MaterialPageRoute(builder: (context) => const LogInPage()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

  _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(
        nameController.text, emailController.text, passwordController.text);
    if (user != null) {
      log("User Created Successfully");
      goToHome(context);
    }
  }
}
