import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });
  final void Function()? onPressed;
  final String text;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: icon,
    );
  }
}
