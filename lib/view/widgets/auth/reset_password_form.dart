import 'package:flutter/material.dart';
import 'package:qrcode_creator/core/constant/validator.dart';
import 'custom_text_field.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
    required this.passController,
    required this.confirmController,
    required this.resetKey,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
  });

  final TextEditingController passController;
  final TextEditingController confirmController;
  final Key resetKey;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: resetKey,
        child: Column(
          children: [
            CustomTextField(
              prefixIcon: Icon(Icons.lock,
                  color: Theme.of(context).colorScheme.primary),
              suffixIcon: IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              hintText: "Enter password",
              controller: passController,
              validator: (value) => Validator.validatePassword(value),
              keyboardType: TextInputType.text,
              obscureText: obscurePassword,
            ),
            CustomTextField(
              prefixIcon: Icon(Icons.lock,
                  color: Theme.of(context).colorScheme.primary),
              suffixIcon: IconButton(
                onPressed: onToggleConfirmPasswordVisibility,
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              hintText: "Confirm password",
              controller: confirmController,
              validator: (value) {
                if (value != passController.text) {
                  return "Passwords don't match!";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              obscureText: obscureConfirmPassword,
            ),
          ],
        ),
      ),
    );
  }
}
