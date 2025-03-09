import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CustomOtpTextField extends StatelessWidget {
  const CustomOtpTextField({
    super.key,
    required this.onSubmit,
  });

  final void Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: OtpTextField(
        fieldWidth: 50.0,
        borderRadius: BorderRadius.circular(20),
        numberOfFields: 5,
        borderColor: Theme.of(context).colorScheme.primary,
        focusedBorderColor: Theme.of(context).colorScheme.secondary,
        // OTP field style
        showFieldAsBox: true,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        // Runs when a code is typed in
        onCodeChanged: (String code) {
          // Handle validation or checks here if needed
        },
        // Runs when every text field is filled
        onSubmit: (String verificationCode) {
          if (verificationCode.length == 5) {
            onSubmit?.call(verificationCode);
          }
        },
      ),
    );
  }
}
