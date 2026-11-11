import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/core/localization/api_error_message.dart';
import 'package:structure_flutter/core/localization/app_l10n.dart';
import 'package:structure_flutter/core/networking/api_error_handler.dart';
import 'package:structure_flutter/core/networking/apis_constant.dart';

void main() {
  // AppL10n is global: put English back for the other tests.
  tearDown(() => AppL10n.update(const Locale('en')));

  group('localizedApiMessage', () {
    test('turns the error keys into text instead of showing the key', () {
      expect(
        localizedApiMessage(ApiErrorsMessage.noInternetError),
        'No internet connection. Please check your connection and try again.',
      );
      expect(
        localizedApiMessage(ResponseMessage.defaultError),
        'Something went wrong. Please try again.',
      );
    });

    test('keeps the server message as it is', () {
      expect(localizedApiMessage('Invalid credentials'), 'Invalid credentials');
    });

    test('falls back to the generic error when there is no message', () {
      expect(localizedApiMessage(null), AppL10n.current.errorDefault);
      expect(localizedApiMessage(''), AppL10n.current.errorDefault);
    });

    test('follows the current language', () {
      AppL10n.update(const Locale('ar'));

      expect(
        localizedApiMessage(ApiErrorsMessage.timeoutError),
        'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.',
      );
    });
  });

  group('AppValidator in Arabic', () {
    setUp(() => AppL10n.update(const Locale('ar')));

    test('uses the field name it is given', () {
      expect(AppValidator.name('', 'الاسم الأول'), 'حقل الاسم الأول مطلوب');
      expect(AppValidator.required(''), 'هذا الحقل مطلوب');
    });

    test('uses the right plural form for each number', () {
      // 3–10 → few, 11–99 → many.
      expect(AppValidator.otp('12', length: 4), contains('4 أرقام'));
      expect(AppValidator.nationalId('1'), contains('14 رقمًا'));
      expect(
        AppValidator.name('أح', 'الاسم الأول'),
        'يجب أن يتراوح طول حقل الاسم الأول بين 3 و30 حرفًا',
      );
      expect(AppValidator.password('1', minLength: 2), contains('حرفين'));
    });

    test('minimum age message', () {
      final now = DateTime.now();
      final tooYoung =
          '${now.year - 10}-${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      expect(
        AppValidator.birthdate(tooYoung),
        'يجب ألا يقل عمرك عن 20 عامًا',
      );
    });
  });
}
