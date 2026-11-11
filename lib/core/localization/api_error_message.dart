import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/core/networking/apis_constant.dart';
import 'package:structure_flutter/l10n/app_localizations.dart';

/// The text to show for an `ApiErrorModel.message`.
///
/// `ErrorHandler` sets that message to either:
/// - the server's own message, already in the user's language (the server
///   gets `Accept-Language`), which is returned unchanged, or
/// - one of the [ApiErrorsMessage] keys, when there is no usable server
///   message (no internet, timeout, HTML error page…), which is turned into
///   text in the current language here.
///
/// The networking layer keeps working with keys, so it needs no context and
/// its tests don't depend on the language.
String localizedApiMessage(String? message, [AppLocalizations? l10n]) {
  final strings = l10n ?? AppL10n.current;
  return switch (message) {
    null || '' => strings.errorDefault,
    ApiErrorsMessage.noContent => strings.errorNoContent,
    ApiErrorsMessage.badRequestError => strings.errorBadRequest,
    ApiErrorsMessage.forbiddenError => strings.errorForbidden,
    ApiErrorsMessage.unauthorizedError => strings.errorUnauthorized,
    ApiErrorsMessage.notFoundError => strings.errorNotFound,
    ApiErrorsMessage.conflictError => strings.errorConflict,
    ApiErrorsMessage.internalServerError => strings.errorInternalServer,
    ApiErrorsMessage.unknownError => strings.errorUnknown,
    ApiErrorsMessage.timeoutError => strings.errorTimeout,
    ApiErrorsMessage.defaultError => strings.errorDefault,
    ApiErrorsMessage.cacheError => strings.errorCache,
    ApiErrorsMessage.noInternetError => strings.errorNoInternet,
    _ => message,
  };
}
