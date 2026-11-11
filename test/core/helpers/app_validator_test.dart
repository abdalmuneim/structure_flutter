import 'package:flutter_test/flutter_test.dart';
import 'package:structure_flutter/core/helpers/app_validator.dart';
import 'package:structure_flutter/core/helpers/phone_number.dart';

String _yearsAgo(int years, {int extraDays = 0}) {
  final now = DateTime.now();
  final date = DateTime(now.year - years, now.month, now.day + extraDays);
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}

void main() {
  group('egyptianPhone', () {
    test('accepts 11 digits starting with 010, 011, 012 or 015', () {
      for (final phone in [
        '01012345678',
        '01112345678',
        '01212345678',
        '01512345678',
      ]) {
        expect(AppValidator.egyptianPhone(phone), isNull, reason: phone);
      }
    });

    test('rejects other numbers', () {
      for (final phone in ['', '1012345678', '0101234567', '01312345678']) {
        expect(AppValidator.egyptianPhone(phone), isNotNull, reason: phone);
      }
    });

    test('is converted to +20 without the leading 0', () {
      expect(
        PhoneNumber.egyptianInternational('01012345678'),
        '+201012345678',
      );
    });
  });

  group('name', () {
    test('accepts 3 to 30 English or Arabic letters', () {
      expect(AppValidator.name('Ahmed', 'First Name'), isNull);
      expect(AppValidator.name('أحمد', 'First Name'), isNull);
    });

    test('rejects short, long, or non-letter names', () {
      expect(AppValidator.name('Al', 'First Name'), contains('between 3'));
      expect(AppValidator.name('A' * 31, 'First Name'), contains('between 3'));
      expect(AppValidator.name('Ahmed1', 'First Name'), contains('letters'));
      expect(AppValidator.name('', 'First Name'), 'First Name is required');
    });
  });

  group('birthdate', () {
    test('accepts a date at least 20 years ago', () {
      expect(AppValidator.birthdate(_yearsAgo(20)), isNull);
      expect(AppValidator.birthdate(_yearsAgo(40)), isNull);
    });

    test('rejects younger than 20, invalid or badly formatted dates', () {
      expect(
        AppValidator.birthdate(_yearsAgo(20, extraDays: 1)),
        contains('at least 20'),
      );
      expect(AppValidator.birthdate('1990-02-30'), contains('valid'));
      expect(AppValidator.birthdate('31/01/1990'), contains('valid'));
      expect(AppValidator.birthdate(''), 'Date of birth is required');
    });
  });
}
