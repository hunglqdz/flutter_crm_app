import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const MyButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FilledButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue)),
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(fontSize: 20),
            )));
  }
}
