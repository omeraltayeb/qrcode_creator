import 'package:flutter/material.dart';

import '../../../core/constant/validator.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    this.registeKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmController,
    required this.obscureText,
    required this.togglevisibility,
  });

  final Key? registeKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final bool obscureText;
  final void Function()? togglevisibility;

  @override
  Widget build(BuildContext context) {
    final focusEmail = FocusNode();
    final focusPassword = FocusNode();
    final focusConfirm = FocusNode();

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: registeKey,
        child: Column(
          children: [
            // Name Field
            CustomTextField(
              prefixIcon: Icon(Icons.person,
                  color: Theme.of(context).colorScheme.primary),
              hintText: 'Enter your name',
              controller: nameController,
              validator: (value) => Validator.validateName(value),
              keyboardType: TextInputType.text,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(focusEmail);
              },
            ),

            const SizedBox(height: 10),

            // Email Field
            CustomTextField(
              prefixIcon: Icon(Icons.email,
                  color: Theme.of(context).colorScheme.primary),
              hintText: 'Enter your email',
              controller: emailController,
              validator: (value) => Validator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
              focusNode: focusEmail,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(focusPassword);
              },
            ),

            const SizedBox(height: 10),

            // Password Field
            CustomTextField(
              prefixIcon: Icon(Icons.lock,
                  color: Theme.of(context).colorScheme.primary),
              hintText: 'Enter your password',
              controller: passwordController,
              obscureText: obscureText,
              validator: (value) => Validator.validatePassword(value),
              keyboardType: TextInputType.text,
              focusNode: focusPassword,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(focusConfirm);
              },
              suffixIcon: IconButton(
                onPressed: togglevisibility,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Confirm Password Field
            CustomTextField(
              prefixIcon: Icon(Icons.lock,
                  color: Theme.of(context).colorScheme.primary),
              hintText: 'Confirm your password',
              controller: confirmController,
              obscureText: obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (passwordController.text != confirmController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              focusNode: focusConfirm,
              suffixIcon: IconButton(
                onPressed: togglevisibility,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
