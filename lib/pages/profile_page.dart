import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crm_app/auth/auth_service.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _auth = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = user.displayName!;
    emailController.text = user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _signout, icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 30),
              MyTextField(
                hint: "Enter New Name",
                label: "Name",
                icon: Icons.abc,
                controller: nameController,
              ),
              const SizedBox(height: 20),
              MyTextField(
                hint: "Enter New Email",
                label: "Email",
                icon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  MyButton(
                    label: "Update",
                    onPressed: _update,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _update() async {
    await user.updateDisplayName(nameController.text);
    await user.verifyBeforeUpdateEmail(emailController.text);
  }

  _signout() async {
    await _auth.signOut(context);
  }
}
