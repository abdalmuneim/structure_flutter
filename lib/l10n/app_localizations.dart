import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Brand name, shown as the app/task-switcher title. Kept as the brand in every language.
  ///
  /// In en, this message translates to:
  /// **'VCare'**
  String get appTitle;

  /// Name of the English language, always written in English (endonym).
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Name of the Arabic language, always written in Arabic (endonym).
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// Tooltip of the button that switches the app language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get languageChange;

  /// Settings row that opens the language picker.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Title of the bottom sheet that lists the available languages.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get settingsChooseLanguage;

  /// Button that moves to the next page/step.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// Call-to-action button that starts using the app (last onboarding page, phone screen).
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get commonGetStarted;

  /// Slogan under the logo on the splash screen.
  ///
  /// In en, this message translates to:
  /// **'Your Health, Our Priority'**
  String get splashTagline;

  /// Skips the onboarding pages and goes to sign in.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// Onboarding page counter under the dots, e.g. 1/3 = page 1 of 3.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total}'**
  String onboardingPageIndicator(int current, int total);

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to VCare'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your health is our priority. Get access to top doctors and medical services.'**
  String get onboardingWelcomeDescription;

  /// No description provided for @onboardingBookTitle.
  ///
  /// In en, this message translates to:
  /// **'Book Appointments'**
  String get onboardingBookTitle;

  /// No description provided for @onboardingBookDescription.
  ///
  /// In en, this message translates to:
  /// **'Schedule appointments with specialists easily and quickly.'**
  String get onboardingBookDescription;

  /// Title of the last onboarding page (not the button).
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingStartTitle;

  /// No description provided for @onboardingStartDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your account and start your health journey today.'**
  String get onboardingStartDescription;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Let’s Sign In'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to get started'**
  String get authLoginSubtitle;

  /// Label above the mobile phone number field.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get authPhoneLabel;

  /// Under the phone field: the same screen is used to sign in and to sign up.
  ///
  /// In en, this message translates to:
  /// **'New here? You will create your account in the next step.'**
  String get authLoginNewUserHint;

  /// Primary button that submits the current form/step.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// Button that closes a message dialog.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// Button that dismisses an information/alert dialog.
  ///
  /// In en, this message translates to:
  /// **'GOT IT'**
  String get commonGotIt;

  /// Tooltip of the back arrow button.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// Small action inside a text field that makes it editable.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// Label of the search box in a drop-down list.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// Placeholder of the search box in a drop-down list.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get commonSearchHint;

  /// Shown when a list or search has no results.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get commonNoDataFound;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up For Free'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account for {phone}'**
  String registerSubtitle(String phone);

  /// No description provided for @registerSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Successful!'**
  String get registerSuccessTitle;

  /// No description provided for @registerSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account for {phone} is ready'**
  String registerSuccessSubtitle(String phone);

  /// Form label; the * marks a required field.
  ///
  /// In en, this message translates to:
  /// **'First Name *'**
  String get registerFirstNameLabel;

  /// Field name inserted into validation errors, e.g. "First Name is required".
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get registerFirstNameField;

  /// Form label for the family name; the * marks a required field.
  ///
  /// In en, this message translates to:
  /// **'Last Name *'**
  String get registerLastNameLabel;

  /// Field name inserted into validation errors, e.g. "Last Name is required".
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get registerLastNameField;

  /// No description provided for @registerEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address *'**
  String get registerEmailLabel;

  /// No description provided for @registerBirthdateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth *'**
  String get registerBirthdateLabel;

  /// No description provided for @registerGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender *'**
  String get registerGenderLabel;

  /// No description provided for @registerGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get registerGenderMale;

  /// No description provided for @registerGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get registerGenderFemale;

  /// Error under the gender choice when none is picked.
  ///
  /// In en, this message translates to:
  /// **'Gender required'**
  String get registerGenderRequired;

  /// No description provided for @registerAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the Terms & Conditions'**
  String get registerAcceptTerms;

  /// No description provided for @registerTermsRequired.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms and conditions to proceed'**
  String get registerTermsRequired;

  /// No description provided for @registerSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'You have successfully created your account. Confirm your phone number with the code we send you to continue.'**
  String get registerSuccessMessage;

  /// Button that opens the SMS code screen to confirm the phone number.
  ///
  /// In en, this message translates to:
  /// **'Verify Phone Number'**
  String get registerVerifyPhone;

  /// Title of the screen where the user types the code received by SMS (OTP = one-time password).
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Enter 1 digit OTP Code} other{Enter {count} digit OTP Code}}'**
  String otpTitle(int count);

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We sent a code to {phone}'**
  String otpSubtitle(String phone);

  /// Shown while the code can't be resent yet; time is a mm:ss countdown.
  ///
  /// In en, this message translates to:
  /// **'You can send again after {time}'**
  String otpResendCountdown(String time);

  /// No description provided for @otpDidNotReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the code?'**
  String get otpDidNotReceive;

  /// Button that sends a new SMS code.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get otpResend;

  /// Confirmation toast after a new SMS code was sent.
  ///
  /// In en, this message translates to:
  /// **'OTP sent again'**
  String get otpResent;

  /// Bottom bar tab and screen title. Keep short: 4 tabs share the bar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mainTabHome;

  /// Bottom bar tab and screen title. Keep short: 4 tabs share the bar.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get mainTabNotifications;

  /// Bottom bar tab and screen title for the user's own account. Keep short: 4 tabs share the bar.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get mainTabProfile;

  /// Bottom bar tab and screen title. Keep short: 4 tabs share the bar.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get mainTabSettings;

  /// No description provided for @homeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your home feed'**
  String get homeEmptyTitle;

  /// No description provided for @homeEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Content for the home screen will appear here.'**
  String get homeEmptyMessage;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'We will let you know when something arrives.'**
  String get notificationsEmptyMessage;

  /// No description provided for @profileEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get profileEmptyTitle;

  /// No description provided for @profileEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account details will appear here.'**
  String get profileEmptyMessage;

  /// No description provided for @settingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get settingsEmptyTitle;

  /// No description provided for @settingsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Settings options will appear here.'**
  String get settingsEmptyMessage;

  /// The server answered successfully but sent no data.
  ///
  /// In en, this message translates to:
  /// **'There\'s nothing to show here yet.'**
  String get errorNoContent;

  /// No description provided for @errorBadRequest.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t process this request. Please check your details and try again.'**
  String get errorBadRequest;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to do this.'**
  String get errorForbidden;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get errorUnauthorized;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find what you were looking for.'**
  String get errorNotFound;

  /// No description provided for @errorConflict.
  ///
  /// In en, this message translates to:
  /// **'This conflicts with existing data.'**
  String get errorConflict;

  /// No description provided for @errorInternalServer.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our side. Please try again later.'**
  String get errorInternalServer;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get errorUnknown;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The connection timed out. Please try again.'**
  String get errorTimeout;

  /// Generic error when nothing more specific is known.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorDefault;

  /// No description provided for @errorCache.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the saved data.'**
  String get errorCache;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your connection and try again.'**
  String get errorNoInternet;

  /// Form error for an empty required field whose name isn't given.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationRequired;

  /// Form error for an empty required field.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is required'**
  String validationFieldRequired(String fieldName);

  /// Default field name used in name validation errors.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get validationNameField;

  /// Default field name used in number-range validation errors.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get validationValueField;

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Password must be at least 1 character} other{Password must be at least {count} characters}}'**
  String validationPasswordMinLength(int count);

  /// No description provided for @validationPasswordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsMismatch;

  /// Password strength error: it needs an uppercase letter, a lowercase letter, a digit and a symbol.
  ///
  /// In en, this message translates to:
  /// **'Must include uppercase, lowercase, number, and special character'**
  String get validationPasswordWeak;

  /// No description provided for @validationPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get validationPhoneRequired;

  /// No description provided for @validationPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get validationPhoneInvalid;

  /// No description provided for @validationUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get validationUsernameRequired;

  /// No description provided for @validationUsernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Username must be 3-30 chars (letters, numbers, . or _)'**
  String get validationUsernameInvalid;

  /// Form error when a field's length is outside a range. Pluralised on the maximum for languages that need it.
  ///
  /// In en, this message translates to:
  /// **'{max, plural, other{{fieldName} must be between {min} and {max} characters}}'**
  String validationFieldLength(String fieldName, int min, int max);

  /// No description provided for @validationLettersOnly.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} must contain letters only'**
  String validationLettersOnly(String fieldName);

  /// No description provided for @validationBirthdateRequired.
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get validationBirthdateRequired;

  /// No description provided for @validationBirthdateInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid date of birth'**
  String get validationBirthdateInvalid;

  /// No description provided for @validationBirthdateFuture.
  ///
  /// In en, this message translates to:
  /// **'Date of birth can’t be today or in the future'**
  String get validationBirthdateFuture;

  /// No description provided for @validationMinimumAge.
  ///
  /// In en, this message translates to:
  /// **'{age, plural, =1{You must be at least 1 year old} other{You must be at least {age} years old}}'**
  String validationMinimumAge(int age);

  /// No description provided for @validationUrlRequired.
  ///
  /// In en, this message translates to:
  /// **'URL is required'**
  String get validationUrlRequired;

  /// No description provided for @validationUrlInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL'**
  String get validationUrlInvalid;

  /// No description provided for @validationMustBeNumber.
  ///
  /// In en, this message translates to:
  /// **'This field must be a number'**
  String get validationMustBeNumber;

  /// No description provided for @validationFieldMustBeNumber.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} must be a number'**
  String validationFieldMustBeNumber(String fieldName);

  /// No description provided for @validationFieldRange.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} must be between {min} and {max}'**
  String validationFieldRange(String fieldName, num min, num max);

  /// No description provided for @validationMinLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{This field must be at least 1 character} other{This field must be at least {count} characters}}'**
  String validationMinLength(int count);

  /// No description provided for @validationFieldMinLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{fieldName} must be at least 1 character} other{{fieldName} must be at least {count} characters}}'**
  String validationFieldMinLength(String fieldName, int count);

  /// No description provided for @validationMaxLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{This field must be at most 1 character} other{This field must be at most {count} characters}}'**
  String validationMaxLength(int count);

  /// No description provided for @validationFieldMaxLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{fieldName} must be at most 1 character} other{{fieldName} must be at most {count} characters}}'**
  String validationFieldMaxLength(String fieldName, int count);

  /// OTP = the one-time verification code sent by SMS.
  ///
  /// In en, this message translates to:
  /// **'OTP is required'**
  String get validationOtpRequired;

  /// No description provided for @validationOtpLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{OTP must be 1 digit} other{OTP must be {count} digits}}'**
  String validationOtpLength(int count);

  /// No description provided for @validationCardRequired.
  ///
  /// In en, this message translates to:
  /// **'Card number is required'**
  String get validationCardRequired;

  /// No description provided for @validationCardInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid card number'**
  String get validationCardInvalid;

  /// No description provided for @validationNationalIdRequired.
  ///
  /// In en, this message translates to:
  /// **'National ID is required'**
  String get validationNationalIdRequired;

  /// No description provided for @validationNationalIdLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{National ID must be 1 digit} other{National ID must be {count} digits}}'**
  String validationNationalIdLength(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
