import 'package:flutter_test/flutter_test.dart';
import 'package:structure_flutter/data/models/api_response.dart';
import 'package:structure_flutter/data/models/handshake.dart';
import 'package:structure_flutter/data/models/login_request.dart';
import 'package:structure_flutter/data/models/register_request.dart';
import 'package:structure_flutter/data/models/user.dart';

/// The JSON must match what lawmate sends and receives.
void main() {
  test('login request body', () {
    const request = LoginRequest(
      phone: '+201012345678',
      otpCode: '1234',
      language: 'en',
    );

    expect(request.toJson(), {
      'phone': '+201012345678',
      'otp_code': '1234',
      'language': 'en',
    });
  });

  test('register request body', () {
    const request = RegisterRequest(
      firstName: 'Ahmed',
      lastName: 'Ali',
      email: 'a@b.com',
      phone: '+201012345678',
      birthdate: '1990-01-31',
      gender: 'male',
    );

    expect(request.withLanguage('ar').toJson(), {
      'first_name': 'Ahmed',
      'last_name': 'Ali',
      'email': 'a@b.com',
      'phone': '+201012345678',
      'birthdate': '1990-01-31',
      'gender': 'male',
      'language': 'ar',
    });
  });

  test('verify-otp and handshake request bodies', () {
    expect(const VerifyOtpRequest(otpCode: '1234').toJson(), {
      'otp_code': '1234',
    });
    expect(const HandshakeRequest(phone: '+201012345678').toJson(), {
      'phone': '+201012345678',
    });
  });

  test('handshake response', () {
    final response = ApiResponse<HandshakeResult>.fromJson(
      {
        'data': {'is_exist': true},
      },
      (json) => HandshakeResult.fromJson(json as Map<String, dynamic>),
    );

    expect(response.data.isExist, isTrue);
  });

  test('user response', () {
    final response = ApiResponse<User>.fromJson(
      {
        'data': {
          'id': 7,
          'first_name': 'Ahmed',
          'last_name': 'Ali',
          'phone': '+201012345678',
          'access_token': 'abc',
          'extra_field_we_ignore': 1,
        },
      },
      (json) => User.fromJson(json as Map<String, dynamic>),
    );

    expect(response.data.id, 7);
    expect(response.data.firstName, 'Ahmed');
    expect(response.data.accessToken, 'abc');
    expect(response.data.verified, isFalse); // missing → false
  });
}
