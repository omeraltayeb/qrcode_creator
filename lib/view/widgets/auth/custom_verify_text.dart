import 'package:flutter/material.dart';

class CustomVerifyText extends StatelessWidget {
  const CustomVerifyText({
    super.key,
    required this.title,
    required this.email,
  });

  final String title;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(fontSize: 16),
            ),
            TextSpan(
              text: email,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
