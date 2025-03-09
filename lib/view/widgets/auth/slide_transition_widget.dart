import 'package:flutter/material.dart';

class SlideTransitionWidget extends StatelessWidget {
  final Widget child;
  const SlideTransitionWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero),
      curve: Curves.easeOut,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: child,
    );
  }
}
