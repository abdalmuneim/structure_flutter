import 'development_keys.dart';
import 'keys.dart';
import 'production_keys.dart';
import 'stage_keys.dart';

enum BuildFlavor { development, staging, production }

/// Which environment this build talks to.
///
/// Choose it when running or building (development when not given):
/// ```
/// flutter run --dart-define=FLAVOR=staging
/// flutter build apk --dart-define=FLAVOR=production
/// ```
class BuildEnvironment {
  BuildEnvironment._();

  static final BuildFlavor flavor = _flavorFromDefine();

  /// Keys for [flavor]. Throws on first use if that flavor has no API URL.
  static final Keys keys = _keysFor(flavor);

  static BuildFlavor _flavorFromDefine() {
    const value = String.fromEnvironment(
      'FLAVOR',
      defaultValue: 'development',
    );
    // An unknown name fails instead of falling back to development, so a
    // typo can't ship a production build that talks to the wrong server.
    return BuildFlavor.values.firstWhere(
      (flavor) => flavor.name == value,
      orElse: () => throw ArgumentError.value(
        value,
        'FLAVOR',
        'Use development, staging or production',
      ),
    );
  }

  static Keys _keysFor(BuildFlavor flavor) {
    final keys = switch (flavor) {
      BuildFlavor.development => DevelopmentKeys(),
      BuildFlavor.staging => StageKeys(),
      BuildFlavor.production => ProductionKeys(),
    };
    if (keys.apiUrl.isEmpty) {
      throw StateError(
        'No apiUrl for the ${flavor.name} flavor. '
        'Set it in lib/core/environment/.',
      );
    }
    return keys;
  }
}
