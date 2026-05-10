// lib/widgets/animated/animated_page_route.dart

import 'package:flutter/material.dart';

class AnimatedPageRoute<T>
    extends PageRouteBuilder<T> {
  final Widget page;

  AnimatedPageRoute({
    required this.page,
  }) : super(
          transitionDuration:
              const Duration(
            milliseconds: 400,
          ),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin:
                      const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
        );
}