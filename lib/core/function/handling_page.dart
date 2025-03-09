import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HandlingPage extends StatelessWidget {
  const HandlingPage({
    super.key,
    required this.isLoading,
    this.serverErrorMessage,
    this.data,
    required this.child,
  });

  final bool isLoading;
  final String? serverErrorMessage;
  final List? data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (serverErrorMessage != null && serverErrorMessage!.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/nointernet.json', height: 150),
            const SizedBox(height: 20),
            Text(
              'No internet access',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (data != null && data!.isEmpty) {
      return Center(
        child: Lottie.asset('assets/lottie/nodata.json', height: 150),
      );
    }

    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(10),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          opacity: 1.0,
          child: child,
        ),
      ),
    );
  }
}
