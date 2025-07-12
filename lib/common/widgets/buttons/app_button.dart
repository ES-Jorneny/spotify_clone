import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(height??80)),
      child: Text(text),
    );
  }
}
