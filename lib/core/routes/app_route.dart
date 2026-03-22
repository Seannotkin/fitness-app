import 'package:flutter/material.dart';

class AppRoute<T> extends PageRouteBuilder<T> {
  AppRoute({required Widget page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 280),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curve = CurveTween(curve: Curves.easeInOutCubic);

            // Incoming page slides in from the right
            final slideIn = animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(curve),
            );

            // Outgoing page slides out to the left (subtle, 30%)
            final slideOut = secondaryAnimation.drive(
              Tween(begin: Offset.zero, end: const Offset(-0.3, 0.0))
                  .chain(curve),
            );

            return SlideTransition(
              position: slideOut,
              child: SlideTransition(position: slideIn, child: child),
            );
          },
        );
}
