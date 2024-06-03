import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final String label;
  final IconData icon;
  final TextEditingController? controller;

  const MyTextField({
    super.key,
    required this.hint,
    required this.label,
    required this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: label == 'Password' ? true : false,
      keyboardType:
          label == 'Email' ? TextInputType.emailAddress : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          label: Text(label),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey))),
    );
  }
}
