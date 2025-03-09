import 'package:flutter/material.dart';
import '../../../core/constant/validator.dart';
import '/view/widgets/auth/custom_text_field.dart';

class CheckEmailForm extends StatelessWidget {
  const CheckEmailForm({
    super.key,
    required this.checkKey,
    required this.text,
    required this.controller,
  });
  final Key? checkKey;
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: checkKey,
        child: Column(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomTextField(
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.primary,
                ),
                hintText: 'Enter your email',
                controller: controller,
                validator: (val) => Validator.validateEmail(val),
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
