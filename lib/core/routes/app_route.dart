import 'package:flutter/material.dart';

class AppRoute<T> extends PageRouteBuilder<T> {
  AppRoute({required Widget page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 280),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = animation.drive(
              Tween(begin: 0.0, end: 1.0)
                  .chain(CurveTween(curve: Curves.easeOut)),
            );
            final slide = animation.drive(
              Tween(begin: const Offset(0, 0.06), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeOutCubic)),
            );
            return FadeTransition(
              opacity: fade,
              child: SlideTransition(position: slide, child: child),
            );
          },
        );
}
