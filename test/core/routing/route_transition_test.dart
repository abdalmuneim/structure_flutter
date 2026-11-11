import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:structure_flutter/core/routing/route_transition.dart';

void main() {
  testWidgets('pushNamed name and arguments reach the builder and ModalRoute', (
    tester,
  ) async {
    Object? builderArguments;
    RouteSettings? modalRouteSettings;
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: const SizedBox(),
        onGenerateRoute: (settings) => RouteTransition.generateRoute(
          settings: settings,
          transition: TransitionType.rightToLeft,
          builder: (context, arguments) {
            builderArguments = arguments;
            return Builder(
              builder: (context) {
                modalRouteSettings = ModalRoute.of(context)!.settings;
                return const SizedBox();
              },
            );
          },
        ),
      ),
    );

    navigatorKey.currentState!.pushNamed('details', arguments: 42);
    await tester.pumpAndSettle();

    expect(builderArguments, 42);
    expect(modalRouteSettings?.name, 'details');
    expect(modalRouteSettings?.arguments, 42);
  });
}
