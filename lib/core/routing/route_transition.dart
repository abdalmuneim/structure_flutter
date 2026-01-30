import 'package:flutter/cupertino.dart';

enum TransitionType {
  defaultTransition,
  fadeIn,
  noTransition,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
  custom,
}

class RouteTransition {
  // routeArgs is not required anymore; builders can access arguments via ModalRoute
  static Route<dynamic> generateRoute({
    required Widget Function(BuildContext, dynamic) builder,
    TransitionType transition = TransitionType.defaultTransition,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          builder(context, ModalRoute.of(context)?.settings.arguments),
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case TransitionType.fadeIn:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.noTransition:
            return child;
          case TransitionType.rightToLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.leftToRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.upToDown:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.downToUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.rotate:
            return RotationTransition(turns: animation, child: child);
          case TransitionType.size:
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          case TransitionType.rightToLeftWithFade:
            return Stack(
              children: <Widget>[
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              ],
            );
          case TransitionType.leftToRightWithFade:
            return Stack(
              children: <Widget>[
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              ],
            );
          case TransitionType.custom:
            // You can define your custom transition here
            // Example: return yourCustomTransition(animation, secondaryAnimation, child);
            break;
          default:
            break;
        }
        return child;
      },
    );
  }
}
