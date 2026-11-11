import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:structure_flutter/core/routing/generate_route.dart';
import 'package:structure_flutter/core/routing/route_path.dart';
import 'package:structure_flutter/presentation/modules/main/models/main_tab.dart';

/// Opens the main route the same way the app does: by name, through
/// GenerateRoute, with optional arguments.
Future<void> _openMain(WidgetTester tester, {Object? arguments}) async {
  final navigatorKey = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      home: const SizedBox(),
      onGenerateRoute: GenerateRoute.generateRoute,
    ),
  );
  navigatorKey.currentState!.pushNamed(RoutePath.main, arguments: arguments);
  await tester.pumpAndSettle();
}

/// The label of a tab in the bottom bar (the tab's AppBar has the same text).
Finder _tab(String label) => find.descendant(
  of: find.byType(BottomNavigationBar),
  matching: find.text(label),
);

void main() {
  testWidgets('opens on Home and shows four tabs', (tester) async {
    await _openMain(tester);

    expect(find.text('Your home feed'), findsOneWidget);
    for (final label in ['Home', 'Notifications', 'Profile', 'Settings']) {
      expect(_tab(label), findsOneWidget);
    }
  });

  testWidgets('tapping a tab shows its scene', (tester) async {
    await _openMain(tester);

    await tester.tap(_tab('Notifications'));
    await tester.pumpAndSettle();
    expect(find.text('No notifications yet'), findsOneWidget);
    expect(find.text('Your home feed'), findsNothing);

    await tester.tap(_tab('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Your profile'), findsOneWidget);

    await tester.tap(_tab('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('App settings'), findsOneWidget);

    await tester.tap(_tab('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Your home feed'), findsOneWidget);
  });

  testWidgets('opens the tab passed as the route argument', (tester) async {
    await _openMain(tester, arguments: MainTab.profile);

    expect(find.text('Your profile'), findsOneWidget);
    expect(find.text('Your home feed'), findsNothing);
  });
}
