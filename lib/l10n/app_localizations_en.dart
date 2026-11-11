// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VCare';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageChange => 'Change language';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsChooseLanguage => 'Choose language';

  @override
  String get commonNext => 'Next';

  @override
  String get commonGetStarted => 'Get Started';

  @override
  String get splashTagline => 'Your Health, Our Priority';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String onboardingPageIndicator(int current, int total) {
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$currentString/$totalString';
  }

  @override
  String get onboardingWelcomeTitle => 'Welcome to VCare';

  @override
  String get onboardingWelcomeDescription =>
      'Your health is our priority. Get access to top doctors and medical services.';

  @override
  String get onboardingBookTitle => 'Book Appointments';

  @override
  String get onboardingBookDescription =>
      'Schedule appointments with specialists easily and quickly.';

  @override
  String get onboardingStartTitle => 'Get Started';

  @override
  String get onboardingStartDescription =>
      'Create your account and start your health journey today.';

  @override
  String get authLoginTitle => 'Let’s Sign In';

  @override
  String get authLoginSubtitle => 'Enter your phone number to get started';

  @override
  String get authPhoneLabel => 'Phone Number';

  @override
  String get authLoginNewUserHint =>
      'New here? You will create your account in the next step.';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonOk => 'OK';

  @override
  String get commonGotIt => 'GOT IT';

  @override
  String get commonBack => 'Back';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonSearchHint => 'Search...';

  @override
  String get commonNoDataFound => 'No data found';

  @override
  String get registerTitle => 'Sign Up For Free';

  @override
  String registerSubtitle(String phone) {
    return 'Create your account for $phone';
  }

  @override
  String get registerSuccessTitle => 'Sign Up Successful!';

  @override
  String registerSuccessSubtitle(String phone) {
    return 'Your account for $phone is ready';
  }

  @override
  String get registerFirstNameLabel => 'First Name *';

  @override
  String get registerFirstNameField => 'First Name';

  @override
  String get registerLastNameLabel => 'Last Name *';

  @override
  String get registerLastNameField => 'Last Name';

  @override
  String get registerEmailLabel => 'Email Address *';

  @override
  String get registerBirthdateLabel => 'Date of Birth *';

  @override
  String get registerGenderLabel => 'Gender *';

  @override
  String get registerGenderMale => 'Male';

  @override
  String get registerGenderFemale => 'Female';

  @override
  String get registerGenderRequired => 'Gender required';

  @override
  String get registerAcceptTerms => 'I accept the Terms & Conditions';

  @override
  String get registerTermsRequired =>
      'You must accept the terms and conditions to proceed';

  @override
  String get registerSuccessMessage =>
      'You have successfully created your account. Confirm your phone number with the code we send you to continue.';

  @override
  String get registerVerifyPhone => 'Verify Phone Number';

  @override
  String otpTitle(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Enter $countString digit OTP Code',
      one: 'Enter 1 digit OTP Code',
    );
    return '$_temp0';
  }

  @override
  String otpSubtitle(String phone) {
    return 'We sent a code to $phone';
  }

  @override
  String otpResendCountdown(String time) {
    return 'You can send again after $time';
  }

  @override
  String get otpDidNotReceive => 'Didn’t receive the code?';

  @override
  String get otpResend => 'Resend OTP';

  @override
  String get otpResent => 'OTP sent again';

  @override
  String get mainTabHome => 'Home';

  @override
  String get mainTabNotifications => 'Notifications';

  @override
  String get mainTabProfile => 'Profile';

  @override
  String get mainTabSettings => 'Settings';

  @override
  String get homeEmptyTitle => 'Your home feed';

  @override
  String get homeEmptyMessage =>
      'Content for the home screen will appear here.';

  @override
  String get notificationsEmptyTitle => 'No notifications yet';

  @override
  String get notificationsEmptyMessage =>
      'We will let you know when something arrives.';

  @override
  String get profileEmptyTitle => 'Your profile';

  @override
  String get profileEmptyMessage => 'Your account details will appear here.';

  @override
  String get settingsEmptyTitle => 'App settings';

  @override
  String get settingsEmptyMessage => 'Settings options will appear here.';

  @override
  String get errorNoContent => 'There\'s nothing to show here yet.';

  @override
  String get errorBadRequest =>
      'We couldn\'t process this request. Please check your details and try again.';

  @override
  String get errorForbidden => 'You don\'t have permission to do this.';

  @override
  String get errorUnauthorized =>
      'Your session has expired. Please sign in again.';

  @override
  String get errorNotFound => 'We couldn\'t find what you were looking for.';

  @override
  String get errorConflict => 'This conflicts with existing data.';

  @override
  String get errorInternalServer =>
      'Something went wrong on our side. Please try again later.';

  @override
  String get errorUnknown => 'An unknown error occurred.';

  @override
  String get errorTimeout => 'The connection timed out. Please try again.';

  @override
  String get errorDefault => 'Something went wrong. Please try again.';

  @override
  String get errorCache => 'We couldn\'t load the saved data.';

  @override
  String get errorNoInternet =>
      'No internet connection. Please check your connection and try again.';

  @override
  String get validationRequired => 'This field is required';

  @override
  String validationFieldRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String get validationNameField => 'Name';

  @override
  String get validationValueField => 'Value';

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationEmailInvalid => 'Enter a valid email';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String validationPasswordMinLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Password must be at least $countString characters',
      one: 'Password must be at least 1 character',
    );
    return '$_temp0';
  }

  @override
  String get validationPasswordsMismatch => 'Passwords do not match';

  @override
  String get validationPasswordWeak =>
      'Must include uppercase, lowercase, number, and special character';

  @override
  String get validationPhoneRequired => 'Phone number is required';

  @override
  String get validationPhoneInvalid => 'Enter a valid phone number';

  @override
  String get validationUsernameRequired => 'Username is required';

  @override
  String get validationUsernameInvalid =>
      'Username must be 3-30 chars (letters, numbers, . or _)';

  @override
  String validationFieldLength(String fieldName, int min, int max) {
    final intl.NumberFormat minNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String minString = minNumberFormat.format(min);
    final intl.NumberFormat maxNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String maxString = maxNumberFormat.format(max);

    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: '$fieldName must be between $minString and $maxString characters',
    );
    return '$_temp0';
  }

  @override
  String validationLettersOnly(String fieldName) {
    return '$fieldName must contain letters only';
  }

  @override
  String get validationBirthdateRequired => 'Date of birth is required';

  @override
  String get validationBirthdateInvalid => 'Please enter a valid date of birth';

  @override
  String get validationBirthdateFuture =>
      'Date of birth can’t be today or in the future';

  @override
  String validationMinimumAge(int age) {
    final intl.NumberFormat ageNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String ageString = ageNumberFormat.format(age);

    String _temp0 = intl.Intl.pluralLogic(
      age,
      locale: localeName,
      other: 'You must be at least $ageString years old',
      one: 'You must be at least 1 year old',
    );
    return '$_temp0';
  }

  @override
  String get validationUrlRequired => 'URL is required';

  @override
  String get validationUrlInvalid => 'Enter a valid URL';

  @override
  String get validationMustBeNumber => 'This field must be a number';

  @override
  String validationFieldMustBeNumber(String fieldName) {
    return '$fieldName must be a number';
  }

  @override
  String validationFieldRange(String fieldName, num min, num max) {
    final intl.NumberFormat minNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String minString = minNumberFormat.format(min);
    final intl.NumberFormat maxNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String maxString = maxNumberFormat.format(max);

    return '$fieldName must be between $minString and $maxString';
  }

  @override
  String validationMinLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This field must be at least $countString characters',
      one: 'This field must be at least 1 character',
    );
    return '$_temp0';
  }

  @override
  String validationFieldMinLength(String fieldName, int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$fieldName must be at least $countString characters',
      one: '$fieldName must be at least 1 character',
    );
    return '$_temp0';
  }

  @override
  String validationMaxLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This field must be at most $countString characters',
      one: 'This field must be at most 1 character',
    );
    return '$_temp0';
  }

  @override
  String validationFieldMaxLength(String fieldName, int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$fieldName must be at most $countString characters',
      one: '$fieldName must be at most 1 character',
    );
    return '$_temp0';
  }

  @override
  String get validationOtpRequired => 'OTP is required';

  @override
  String validationOtpLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'OTP must be $countString digits',
      one: 'OTP must be 1 digit',
    );
    return '$_temp0';
  }

  @override
  String get validationCardRequired => 'Card number is required';

  @override
  String get validationCardInvalid => 'Enter a valid card number';

  @override
  String get validationNationalIdRequired => 'National ID is required';

  @override
  String validationNationalIdLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'National ID must be $countString digits',
      one: 'National ID must be 1 digit',
    );
    return '$_temp0';
  }
}
