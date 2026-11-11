import 'keys.dart';

/// No staging server yet (lawmate's stage URLs are empty too).
/// Fill these in before building with `--dart-define=FLAVOR=staging`;
/// until then that build stops at startup with a clear error.
class StageKeys extends Keys {
  @override
  final String apiUrl = '';

  @override
  final String baseUrl = '';
}
