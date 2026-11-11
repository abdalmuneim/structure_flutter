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
  /// Builds a route with the given [transition].
  ///
  /// [settings] must be the `RouteSettings` that `onGenerateRoute` received.
  /// It gives the route its name and arguments, so [builder] gets the
  /// arguments and screens can read `ModalRoute.of(context)!.settings`.
  static Route<dynamic> generateRoute({
    required RouteSettings settings,
    required Widget Function(BuildContext context, Object? arguments) builder,
    TransitionType transition = TransitionType.defaultTransition,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          builder(context, settings.arguments),
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Horizontal slides follow the reading direction: in Arabic (RTL)
        // "rightToLeft" comes in from the left, so "forward" feels the same
        // in both languages.
        final dx = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
        switch (transition) {
          case TransitionType.fadeIn:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.noTransition:
            return child;
          case TransitionType.rightToLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(dx, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.leftToRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-dx, 0.0),
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
                    begin: Offset(dx, 0.0),
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
                    begin: Offset(-dx, 0.0),
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
