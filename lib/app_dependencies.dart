import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:structure_flutter/core/localization/locale_controller.dart';
import 'package:structure_flutter/core/networking/dio_factory.dart';
import 'package:structure_flutter/data/remote/auth_api.dart';
import 'package:structure_flutter/data/repos_imp/auth_repo_imp.dart';
import 'package:structure_flutter/domain/repos/auth_repo.dart';

/// Creates the app-wide objects (repositories) once, above `MaterialApp`.
///
/// Routes read them with `context.read<AuthRepo>()` and pass them to use
/// cases. Code depends on the interface (`AuthRepo`), so a test can put a
/// fake implementation here instead.
///
/// When you add a feature: create its API + `XRepoImp` in `data/`, its
/// `XRepo` interface in `domain/repos/`, and register it below.
///
/// App-wide state lives here too: [LocaleController] (the app language).
class AppDependencies extends StatelessWidget {
  const AppDependencies({
    super.key,
    required this.child,
    this.savedLanguageCode,
  });

  final Widget child;

  /// The language saved from the previous run, read before `runApp`.
  final String? savedLanguageCode;

  @override
  Widget build(BuildContext context) {
    final dio = DioFactory.getDio();

    return MultiProvider(
      providers: [
        Provider<AuthRepo>(create: (_) => AuthRepoImp(AuthApi(dio))),
        ChangeNotifierProvider<LocaleController>(
          create: (_) => LocaleController(savedLanguageCode: savedLanguageCode),
        ),
      ],
      child: child,
    );
  }
}
