import 'package:flutter/material.dart';

class TooltipChangeText extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  final Color backgroundColor;

  const TooltipChangeText({
    super.key,
    required this.message,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(backgroundColor: backgroundColor),
      ),
    );
  }
}
