import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final Widget child;

  const DefaultButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: child,
    );
  }
}
