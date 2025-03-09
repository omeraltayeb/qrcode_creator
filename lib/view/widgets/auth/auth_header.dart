import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.name, required this.height});
  final String name;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      name,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
