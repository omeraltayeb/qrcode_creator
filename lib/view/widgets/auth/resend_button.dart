import 'package:flutter/material.dart';

class ResendCodeTimer extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const ResendCodeTimer({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        foregroundColor: onPressed != null
            ? Theme.of(context).colorScheme.primary
            : Colors.grey,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(onPressed != null ? 1.0 : 0.95),
        child: child,
      ),
    );
  }
}
