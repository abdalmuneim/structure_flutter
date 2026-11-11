/// Values that change per environment: server URLs, and later any API keys.
///
/// One subclass per flavor: [DevelopmentKeys], [StageKeys], [ProductionKeys].
/// `BuildEnvironment.keys` gives the one for the current build.
///
/// Don't commit real secrets here. Read them with
/// `String.fromEnvironment('NAME')` and pass them at build time with
/// `--dart-define=NAME=value`, so they stay out of git.
abstract class Keys {
  /// REST API root. Every endpoint in `ApiConstants` is relative to it.
  String get apiUrl;

  /// Site root, e.g. for building full image URLs.
  String get baseUrl;
}
