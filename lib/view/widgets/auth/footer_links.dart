import 'package:flutter/material.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({
    super.key,
    required this.text,
    required this.btnText,
    this.onPressed,
  });
  final String text;
  final String btnText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          TextButton(
            onPressed: onPressed,
            child: Text(btnText),
          ),
        ],
      ),
    );
  }
}
