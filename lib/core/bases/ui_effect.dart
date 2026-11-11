/// Something the screen should do once, such as showing the loading dialog,
/// a toast, or navigating, as opposed to data it renders.
///
/// Providers send effects with the helpers on `BaseProvider`; `BaseScene`
/// handles the ones below. For a feature-specific effect, extend [UiEffect]
/// in the feature folder and handle it in `BaseSceneState.onEffect`.
sealed class UiEffect {
  const UiEffect();
}

class ShowLoadingEffect extends UiEffect {
  const ShowLoadingEffect();
}

class HideLoadingEffect extends UiEffect {
  const HideLoadingEffect();
}

class ShowErrorEffect extends UiEffect {
  const ShowErrorEffect(this.message);

  final String message;
}

class ShowSuccessEffect extends UiEffect {
  const ShowSuccessEffect(this.message);

  final String message;
}

class NavigateEffect extends UiEffect {
  const NavigateEffect(this.route, {this.arguments, this.clearStack = false});

  final String route;
  final Object? arguments;

  /// Removes every previous route, e.g. after login or logout.
  final bool clearStack;
}
