import 'package:flutter/material.dart';
import '../../../core/constant/validator.dart';
import 'custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    this.keyForm,
    required this.emailController,
    required this.passwordController,
    required this.obscureText,
    this.togglevisibility,
  });

  final Key? keyForm;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscureText;
  final void Function()? togglevisibility;

  @override
  Widget build(BuildContext context) {
    final focusPassword = FocusNode();

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Form(
        key: keyForm,
        child: Column(
          children: [
            // Email Field
            CustomTextField(
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).colorScheme.primary,
              ),
              hintText: 'Enter your email',
              controller: emailController,
              validator: (value) => Validator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(focusPassword);
              },
            ),

            const SizedBox(height: 10),

            // Password Field
            CustomTextField(
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).colorScheme.primary,
              ),
              hintText: 'Enter your password',
              controller: passwordController,
              obscureText: obscureText,
              validator: (value) => Validator.validatePassword(value),
              keyboardType: TextInputType.text,
              focusNode: focusPassword,
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
