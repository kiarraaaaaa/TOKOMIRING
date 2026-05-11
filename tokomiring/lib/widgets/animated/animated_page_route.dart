// lib/widgets/animated/animated_page_route.dart

import 'package:flutter/material.dart';

class AnimatedPageRoute<T>
    extends PageRouteBuilder<T> {

  final Widget page;

  final Duration duration;

  final Curve curve;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  AnimatedPageRoute({

    required this.page,

    this.duration =
        const Duration(
      milliseconds: 350,
    ),

    this.curve =
        Curves.easeInOut,
  }) : super(

          transitionDuration:
              duration,

          reverseTransitionDuration:
              duration,

          pageBuilder: (

            context,

            animation,

            secondaryAnimation,

          ) {

            return page;
          },

          transitionsBuilder: (

            context,

            animation,

            secondaryAnimation,

            child,

          ) {

            // ===========================================
            // CURVED ANIMATION
            // ===========================================

            final curvedAnimation =
                CurvedAnimation(

              parent:
                  animation,

              curve:
                  curve,
            );

            // ===========================================
            // FADE
            // ===========================================

            final fadeAnimation =
                Tween<double>(

              begin: 0,

              end: 1,
            ).animate(
              curvedAnimation,
            );

            // ===========================================
            // SLIDE
            // ===========================================

            final slideAnimation =
                Tween<Offset>(

              begin:
                  const Offset(
                0.08,
                0,
              ),

              end:
                  Offset.zero,
            ).animate(

              CurvedAnimation(

                parent:
                    animation,

                curve:
                    Curves.easeOutCubic,
              ),
            );

            // ===========================================
            // SCALE
            // ===========================================

            final scaleAnimation =
                Tween<double>(

              begin:
                  0.98,

              end:
                  1,
            ).animate(

              CurvedAnimation(

                parent:
                    animation,

                curve:
                    Curves.easeOut,
              ),
            );

            return FadeTransition(

              opacity:
                  fadeAnimation,

              child: SlideTransition(

                position:
                    slideAnimation,

                child: ScaleTransition(

                  scale:
                      scaleAnimation,

                  child:
                      child,
                ),
              ),
            );
          },
        );

  // =====================================================
  // RIGHT TO LEFT
  // =====================================================

  static Route rightToLeft(
    Widget page,
  ) {

    return PageRouteBuilder(

      transitionDuration:
          const Duration(
        milliseconds: 320,
      ),

      reverseTransitionDuration:
          const Duration(
        milliseconds: 320,
      ),

      pageBuilder: (

        context,

        animation,

        secondaryAnimation,

      ) {

        return page;
      },

      transitionsBuilder: (

        context,

        animation,

        secondaryAnimation,

        child,

      ) {

        final offsetAnimation =
            Tween<Offset>(

          begin:
              const Offset(
            1,
            0,
          ),

          end:
              Offset.zero,
        ).animate(

          CurvedAnimation(

            parent:
                animation,

            curve:
                Curves.easeOutCubic,
          ),
        );

        return SlideTransition(

          position:
              offsetAnimation,

          child:
              child,
        );
      },
    );
  }

  // =====================================================
  // BOTTOM TO TOP
  // =====================================================

  static Route bottomToTop(
    Widget page,
  ) {

    return PageRouteBuilder(

      transitionDuration:
          const Duration(
        milliseconds: 350,
      ),

      reverseTransitionDuration:
          const Duration(
        milliseconds: 350,
      ),

      opaque: false,

      pageBuilder: (

        context,

        animation,

        secondaryAnimation,

      ) {

        return page;
      },

      transitionsBuilder: (

        context,

        animation,

        secondaryAnimation,

        child,

      ) {

        final offsetAnimation =
            Tween<Offset>(

          begin:
              const Offset(
            0,
            1,
          ),

          end:
              Offset.zero,
        ).animate(

          CurvedAnimation(

            parent:
                animation,

            curve:
                Curves.easeOutCubic,
          ),
        );

        final fadeAnimation =
            Tween<double>(

          begin: 0,

          end: 1,
        ).animate(animation);

        return FadeTransition(

          opacity:
              fadeAnimation,

          child: SlideTransition(

            position:
                offsetAnimation,

            child:
                child,
          ),
        );
      },
    );
  }

  // =====================================================
  // SCALE
  // =====================================================

  static Route scale(
    Widget page,
  ) {

    return PageRouteBuilder(

      transitionDuration:
          const Duration(
        milliseconds: 280,
      ),

      reverseTransitionDuration:
          const Duration(
        milliseconds: 280,
      ),

      pageBuilder: (

        context,

        animation,

        secondaryAnimation,

      ) {

        return page;
      },

      transitionsBuilder: (

        context,

        animation,

        secondaryAnimation,

        child,

      ) {

        final scaleAnimation =
            Tween<double>(

          begin:
              0.9,

          end:
              1,
        ).animate(

          CurvedAnimation(

            parent:
                animation,

            curve:
                Curves.easeOutBack,
          ),
        );

        final fadeAnimation =
            Tween<double>(

          begin: 0,

          end: 1,
        ).animate(animation);

        return FadeTransition(

          opacity:
              fadeAnimation,

          child: ScaleTransition(

            scale:
                scaleAnimation,

            child:
                child,
          ),
        );
      },
    );
  }
}