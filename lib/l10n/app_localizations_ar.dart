// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'VCare';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageChange => 'تغيير اللغة';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsChooseLanguage => 'اختر اللغة';

  @override
  String get commonNext => 'التالي';

  @override
  String get commonGetStarted => 'ابدأ الآن';

  @override
  String get splashTagline => 'صحتك أولويتنا';

  @override
  String get onboardingSkip => 'تخطٍّ';

  @override
  String onboardingPageIndicator(int current, int total) {
    final intl.NumberFormat currentNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String currentString = currentNumberFormat.format(current);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return '$currentString من $totalString';
  }

  @override
  String get onboardingWelcomeTitle => 'مرحبًا بك في VCare';

  @override
  String get onboardingWelcomeDescription =>
      'صحتك هي أولويتنا. احصل على أفضل الأطباء والخدمات الطبية بكل سهولة.';

  @override
  String get onboardingBookTitle => 'احجز مواعيدك';

  @override
  String get onboardingBookDescription =>
      'حدّد مواعيدك مع الأطباء المتخصصين بسهولة وسرعة.';

  @override
  String get onboardingStartTitle => 'لنبدأ';

  @override
  String get onboardingStartDescription =>
      'أنشئ حسابك وابدأ رحلتك الصحية اليوم.';

  @override
  String get authLoginTitle => 'تسجيل الدخول';

  @override
  String get authLoginSubtitle => 'أدخل رقم هاتفك للبدء';

  @override
  String get authPhoneLabel => 'رقم الهاتف';

  @override
  String get authLoginNewUserHint =>
      'مستخدم جديد؟ ستنشئ حسابك في الخطوة التالية.';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get commonOk => 'حسنًا';

  @override
  String get commonGotIt => 'حسنًا، فهمت';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonSearch => 'بحث';

  @override
  String get commonSearchHint => 'ابحث...';

  @override
  String get commonNoDataFound => 'لا توجد بيانات';

  @override
  String get registerTitle => 'أنشئ حسابك مجانًا';

  @override
  String registerSubtitle(String phone) {
    return 'أنشئ حسابًا للرقم $phone';
  }

  @override
  String get registerSuccessTitle => 'تم إنشاء حسابك بنجاح!';

  @override
  String registerSuccessSubtitle(String phone) {
    return 'حسابك المرتبط بالرقم $phone جاهز';
  }

  @override
  String get registerFirstNameLabel => 'الاسم الأول *';

  @override
  String get registerFirstNameField => 'الاسم الأول';

  @override
  String get registerLastNameLabel => 'اسم العائلة *';

  @override
  String get registerLastNameField => 'اسم العائلة';

  @override
  String get registerEmailLabel => 'البريد الإلكتروني *';

  @override
  String get registerBirthdateLabel => 'تاريخ الميلاد *';

  @override
  String get registerGenderLabel => 'الجنس *';

  @override
  String get registerGenderMale => 'ذكر';

  @override
  String get registerGenderFemale => 'أنثى';

  @override
  String get registerGenderRequired => 'يرجى اختيار الجنس';

  @override
  String get registerAcceptTerms => 'أوافق على الشروط والأحكام';

  @override
  String get registerTermsRequired =>
      'يجب الموافقة على الشروط والأحكام للمتابعة';

  @override
  String get registerSuccessMessage =>
      'تم إنشاء حسابك بنجاح. أكّد رقم هاتفك بالرمز الذي سنرسله إليك للمتابعة.';

  @override
  String get registerVerifyPhone => 'تأكيد رقم الهاتف';

  @override
  String otpTitle(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أدخل رمز التحقق المكوّن من $countString رقم',
      many: 'أدخل رمز التحقق المكوّن من $countString رقمًا',
      few: 'أدخل رمز التحقق المكوّن من $countString أرقام',
      two: 'أدخل رمز التحقق المكوّن من رقمين',
      one: 'أدخل رمز التحقق المكوّن من رقم واحد',
    );
    return '$_temp0';
  }

  @override
  String otpSubtitle(String phone) {
    return 'أرسلنا رمز التحقق إلى $phone';
  }

  @override
  String otpResendCountdown(String time) {
    return 'يمكنك إعادة الإرسال بعد $time';
  }

  @override
  String get otpDidNotReceive => 'لم يصلك الرمز؟';

  @override
  String get otpResend => 'إعادة إرسال الرمز';

  @override
  String get otpResent => 'أُعيد إرسال الرمز';

  @override
  String get mainTabHome => 'الرئيسية';

  @override
  String get mainTabNotifications => 'الإشعارات';

  @override
  String get mainTabProfile => 'حسابي';

  @override
  String get mainTabSettings => 'الإعدادات';

  @override
  String get homeEmptyTitle => 'صفحتك الرئيسية';

  @override
  String get homeEmptyMessage => 'سيظهر محتوى الصفحة الرئيسية هنا.';

  @override
  String get notificationsEmptyTitle => 'لا توجد إشعارات بعد';

  @override
  String get notificationsEmptyMessage => 'سنُعلمك فور وصول أي جديد.';

  @override
  String get profileEmptyTitle => 'ملفك الشخصي';

  @override
  String get profileEmptyMessage => 'ستظهر تفاصيل حسابك هنا.';

  @override
  String get settingsEmptyTitle => 'إعدادات التطبيق';

  @override
  String get settingsEmptyMessage => 'ستظهر خيارات الإعدادات هنا.';

  @override
  String get errorNoContent => 'لا يوجد ما يمكن عرضه هنا بعد.';

  @override
  String get errorBadRequest =>
      'تعذّرت معالجة طلبك. يرجى مراجعة البيانات والمحاولة مرة أخرى.';

  @override
  String get errorForbidden => 'ليست لديك صلاحية للقيام بهذا الإجراء.';

  @override
  String get errorUnauthorized =>
      'انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get errorNotFound => 'لم نتمكن من العثور على ما تبحث عنه.';

  @override
  String get errorConflict => 'يتعارض هذا مع بيانات موجودة بالفعل.';

  @override
  String get errorInternalServer => 'حدث خطأ من جانبنا. يرجى المحاولة لاحقًا.';

  @override
  String get errorUnknown => 'حدث خطأ غير معروف.';

  @override
  String get errorTimeout => 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';

  @override
  String get errorDefault => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get errorCache => 'تعذّر تحميل البيانات المحفوظة.';

  @override
  String get errorNoInternet =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الاتصال والمحاولة مرة أخرى.';

  @override
  String get validationRequired => 'هذا الحقل مطلوب';

  @override
  String validationFieldRequired(String fieldName) {
    return 'حقل $fieldName مطلوب';
  }

  @override
  String get validationNameField => 'الاسم';

  @override
  String get validationValueField => 'القيمة';

  @override
  String get validationEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get validationEmailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get validationPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String validationPasswordMinLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يجب ألا تقل كلمة المرور عن $countString حرف',
      many: 'يجب ألا تقل كلمة المرور عن $countString حرفًا',
      few: 'يجب ألا تقل كلمة المرور عن $countString أحرف',
      two: 'يجب ألا تقل كلمة المرور عن حرفين',
      one: 'يجب ألا تقل كلمة المرور عن حرف واحد',
    );
    return '$_temp0';
  }

  @override
  String get validationPasswordsMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get validationPasswordWeak =>
      'يجب أن تحتوي على حرف إنجليزي كبير وآخر صغير ورقم ورمز خاص';

  @override
  String get validationPhoneRequired => 'رقم الهاتف مطلوب';

  @override
  String get validationPhoneInvalid => 'أدخل رقم هاتف صحيحًا';

  @override
  String get validationUsernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get validationUsernameInvalid =>
      'يجب أن يتكون اسم المستخدم من 3 إلى 30 خانة (أحرف إنجليزية أو أرقام أو . أو _)';

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
      other: 'يجب أن يتراوح طول حقل $fieldName بين $minString و$maxString حرف',
      many: 'يجب أن يتراوح طول حقل $fieldName بين $minString و$maxString حرفًا',
      few: 'يجب أن يتراوح طول حقل $fieldName بين $minString و$maxString أحرف',
    );
    return '$_temp0';
  }

  @override
  String validationLettersOnly(String fieldName) {
    return 'يجب أن يحتوي حقل $fieldName على حروف فقط';
  }

  @override
  String get validationBirthdateRequired => 'تاريخ الميلاد مطلوب';

  @override
  String get validationBirthdateInvalid => 'يرجى إدخال تاريخ ميلاد صحيح';

  @override
  String get validationBirthdateFuture =>
      'لا يمكن أن يكون تاريخ الميلاد اليوم أو في المستقبل';

  @override
  String validationMinimumAge(int age) {
    final intl.NumberFormat ageNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String ageString = ageNumberFormat.format(age);

    String _temp0 = intl.Intl.pluralLogic(
      age,
      locale: localeName,
      other: 'يجب ألا يقل عمرك عن $ageString عام',
      many: 'يجب ألا يقل عمرك عن $ageString عامًا',
      few: 'يجب ألا يقل عمرك عن $ageString أعوام',
      two: 'يجب ألا يقل عمرك عن عامين',
      one: 'يجب ألا يقل عمرك عن عام واحد',
    );
    return '$_temp0';
  }

  @override
  String get validationUrlRequired => 'الرابط مطلوب';

  @override
  String get validationUrlInvalid => 'أدخل رابطًا صحيحًا';

  @override
  String get validationMustBeNumber => 'يجب أن تكون قيمة هذا الحقل رقمًا';

  @override
  String validationFieldMustBeNumber(String fieldName) {
    return 'يجب أن تكون قيمة حقل $fieldName رقمًا';
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

    return 'يجب أن تكون قيمة حقل $fieldName بين $minString و$maxString';
  }

  @override
  String validationMinLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يجب ألا يقل طول هذا الحقل عن $countString حرف',
      many: 'يجب ألا يقل طول هذا الحقل عن $countString حرفًا',
      few: 'يجب ألا يقل طول هذا الحقل عن $countString أحرف',
      two: 'يجب ألا يقل طول هذا الحقل عن حرفين',
      one: 'يجب ألا يقل طول هذا الحقل عن حرف واحد',
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
      other: 'يجب ألا يقل طول حقل $fieldName عن $countString حرف',
      many: 'يجب ألا يقل طول حقل $fieldName عن $countString حرفًا',
      few: 'يجب ألا يقل طول حقل $fieldName عن $countString أحرف',
      two: 'يجب ألا يقل طول حقل $fieldName عن حرفين',
      one: 'يجب ألا يقل طول حقل $fieldName عن حرف واحد',
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
      other: 'يجب ألا يزيد طول هذا الحقل على $countString حرف',
      many: 'يجب ألا يزيد طول هذا الحقل على $countString حرفًا',
      few: 'يجب ألا يزيد طول هذا الحقل على $countString أحرف',
      two: 'يجب ألا يزيد طول هذا الحقل على حرفين',
      one: 'يجب ألا يزيد طول هذا الحقل على حرف واحد',
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
      other: 'يجب ألا يزيد طول حقل $fieldName على $countString حرف',
      many: 'يجب ألا يزيد طول حقل $fieldName على $countString حرفًا',
      few: 'يجب ألا يزيد طول حقل $fieldName على $countString أحرف',
      two: 'يجب ألا يزيد طول حقل $fieldName على حرفين',
      one: 'يجب ألا يزيد طول حقل $fieldName على حرف واحد',
    );
    return '$_temp0';
  }

  @override
  String get validationOtpRequired => 'رمز التحقق مطلوب';

  @override
  String validationOtpLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يجب أن يتكون رمز التحقق من $countString رقم',
      many: 'يجب أن يتكون رمز التحقق من $countString رقمًا',
      few: 'يجب أن يتكون رمز التحقق من $countString أرقام',
      two: 'يجب أن يتكون رمز التحقق من رقمين',
      one: 'يجب أن يتكون رمز التحقق من رقم واحد',
    );
    return '$_temp0';
  }

  @override
  String get validationCardRequired => 'رقم البطاقة مطلوب';

  @override
  String get validationCardInvalid => 'أدخل رقم بطاقة صحيحًا';

  @override
  String get validationNationalIdRequired => 'الرقم القومي مطلوب';

  @override
  String validationNationalIdLength(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يجب أن يتكون الرقم القومي من $countString رقم',
      many: 'يجب أن يتكون الرقم القومي من $countString رقمًا',
      few: 'يجب أن يتكون الرقم القومي من $countString أرقام',
      two: 'يجب أن يتكون الرقم القومي من رقمين',
      one: 'يجب أن يتكون الرقم القومي من رقم واحد',
    );
    return '$_temp0';
  }
}
