import 'package:flutter/material.dart';

class AppRoute<T> extends PageRouteBuilder<T> {
  /// [reverse] = true when navigating to a screen that is "left" in the nav
  /// bar (lower index). The new page slides in from the left.
  AppRoute({required Widget page, bool reverse = false, bool instant = true})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: instant ? Duration.zero : const Duration(milliseconds: 280),
          reverseTransitionDuration: instant ? Duration.zero : const Duration(milliseconds: 280),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            final dx = reverse ? -1.0 : 1.0;

            // Incoming page slides from right (or left if reverse)
            final slide = animation.drive(
              Tween(begin: Offset(dx, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeOutCubic)),
            );

            // Fade in masks any jump from pushReplacement cutting old page
            final fade = animation.drive(
              Tween(begin: 0.0, end: 1.0)
                  .chain(CurveTween(curve: Curves.easeOut)),
            );

            // Page below slides out slightly (parallax — works for push/pop)
            final secondarySlide = secondaryAnimation.drive(
              Tween(begin: Offset.zero, end: Offset(-dx * 0.25, 0.0))
                  .chain(CurveTween(curve: Curves.easeInCubic)),
            );

            return SlideTransition(
              position: secondarySlide,
              child: FadeTransition(
                opacity: fade,
                child: SlideTransition(position: slide, child: child),
              ),
            );
          },
        );
}
