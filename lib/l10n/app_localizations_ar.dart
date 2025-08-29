// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get spanish => 'الأسبانية';

  @override
  String get frensh => 'الفرنسية';

  @override
  String get german => 'الألمانية';

  @override
  String get turkish => 'التركية';

  @override
  String get ok => 'حسناً';

  @override
  String get back => 'رجوع';

  @override
  String get error => 'خطأ';

  @override
  String get pleaseChoose => 'الرجاء تحديد خيار';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'الاستوديو';

  @override
  String get share => 'شارك';

  @override
  String get errorHappenedWhileTryingToShareTheImage =>
      'حدث خطأ أثناء محاولة مشاركة الصورة.';

  @override
  String get saveToGallery => 'حفظ في الاستوديو';

  @override
  String get imageSavedToGallery => 'تم حفظ الصورة في الاستوديو';

  @override
  String get errorHappenedWhileSavingTheImage =>
      'حدث خطأ أثناء حفظ الصورة في الاستوديو.';

  @override
  String get attention => 'انتباه';

  @override
  String get doYouWantToExit => 'هل تريد الخروج؟';

  @override
  String get exit => 'الخروج';

  @override
  String get cancel => 'إلغاء';

  @override
  String get copyCode => 'إنسخ الكود';

  @override
  String get copid => 'تم النسخ!';

  @override
  String get km => 'كيلومتر';

  @override
  String get meter => 'متر';

  @override
  String get linkIsNotvalid => 'الرابط غير صالح';

  @override
  String get youAreCurrentlyOffline => 'أنت غير متصل بالانترنت';

  @override
  String get linkDoesnotPointToImage => 'الرابط لا يشير إلى الصورة';

  @override
  String get passwordMustBeAtLeastWithDetails =>
      'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل، وأن تحتوي على 5 حروف ورقمين وحرف خاص واحد على الأقل مثل ';

  @override
  String get fiveAlphabetCharacters => '5 حروف';

  @override
  String get twoNumbers => 'رقمين';

  @override
  String get oneSpecialCharachtersLike => 'حرف خاص مثل ';

  @override
  String get passwordMustContainAtLeast => 'يجب أن تحتوي كلمة المرور على الأقل';

  @override
  String get comma => ' و';

  @override
  String get and => 'و';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get at => 'الساعة';

  @override
  String get justNow => 'الآن';

  @override
  String durationAgo(String durationInString) {
    return 'منذ $durationInString';
  }

  @override
  String durationFromNow(String durationInString) {
    return 'بعد $durationInString من الآن';
  }

  @override
  String get second => 'ثانية';

  @override
  String get twoSeconds => 'ثانيتين';

  @override
  String secondsBeteenThreeAndTen(int numberOfSeconds) {
    return '$numberOfSeconds ثواني';
  }

  @override
  String secondsMoreThanTen(int numberOfSeconds) {
    return '$numberOfSeconds ثانية';
  }

  @override
  String get minute => 'دقيقة';

  @override
  String get twoMinutes => 'دقيقتين';

  @override
  String minutesBeteenThreeAndTen(int numberOfMinutes) {
    return '$numberOfMinutes دقائق';
  }

  @override
  String minutesMoreThanTen(int numberOfMinutes) {
    return '$numberOfMinutes دقيقة';
  }

  @override
  String get hour => 'ساعة';

  @override
  String get twoHours => 'ساعتين';

  @override
  String hoursBeteenThreeAndTen(int numberOfHours) {
    return '$numberOfHours ساعات';
  }

  @override
  String hoursMoreThanTen(int numberOfHours) {
    return '$numberOfHours ساعة';
  }

  @override
  String get day => 'يوم';

  @override
  String get twoDays => 'يومين';

  @override
  String daysBeteenThreeAndTen(int numberOfDays) {
    return '$numberOfDays أيام';
  }

  @override
  String daysMoreThanTen(int numberOfDays) {
    return '$numberOfDays يوم';
  }

  @override
  String get week => 'إسبوع';

  @override
  String get twoWeeks => 'إسبوعين';

  @override
  String weeksBeteenThreeAndTen(int numberOfWeeks) {
    return '$numberOfWeeks أسابيع';
  }

  @override
  String weeksMoreThanTen(int numberOfWeeks) {
    return '$numberOfWeeks إسبوع';
  }

  @override
  String get month => 'شهر';

  @override
  String get twoMonths => 'شهرين';

  @override
  String monthsBeteenThreeAndTen(int numberOfMonths) {
    return '$numberOfMonths أشهر';
  }

  @override
  String monthsMoreThanTen(int numberOfMonths) {
    return '$numberOfMonths شهر';
  }

  @override
  String get year => 'سنة';

  @override
  String get twoYears => 'سنتين';

  @override
  String yearsBeteenThreeAndTen(int numberOfYears) {
    return '$numberOfYears سنوات';
  }

  @override
  String yearsMoreThanTen(int numberOfYears) {
    return '$numberOfYears سنة';
  }

  @override
  String get decade => 'عقد';

  @override
  String get twoDecades => 'عقدين';

  @override
  String decadesBeteenThreeAndTen(int numberOfDecades) {
    return '$numberOfDecades عقود';
  }

  @override
  String decadesMoreThanTen(int numberOfDecades) {
    return '$numberOfDecades عقد';
  }

  @override
  String get home => 'الرئيسية';

  @override
  String get forDoctors => 'للأطباء';

  @override
  String get forPatients => 'للمرضى';

  @override
  String get openMenu => 'افتح القائمة';

  @override
  String get profile => 'الحساب الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get shareTheApp => 'شارك التطبيق';

  @override
  String get shareTheAppText =>
      '          \"تطبيق التوعية بسرطان الثدي\"\n\nتمكين الأفراد من تولي مسؤولية صحة ثديهم.\n\nيمكنكم تحميل هذا التطبيق من جوجل بلاي عبر الرابط ادناه \n\nhttps://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness';

  @override
  String get about => 'عن التطبيق';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get checkForUpdates => 'تحقق من وجود تحديثات';

  @override
  String get errorHappendWhileCheckingForUpdates =>
      'حدث خطأ أثناء محاولة البحث عن تحديثات';

  @override
  String get noUpdates => 'لا يوجد تحديثات';

  @override
  String get youHaveTheLatestVersion =>
      'أنت بالفعل لديك اخر تحديث من التطبيق 👍👍';

  @override
  String get needUpdate => 'بحاجة إلى التحديث';

  @override
  String get thisVersionOfTheAppNotSupportedAnymore =>
      'لم يعد هذا الإصدار من التطبيق مدعومًا بعد الآن، عليك التحديث إلى الإصدار الأحدث.';

  @override
  String get update => 'تحديث';

  @override
  String thisVersionOfTheAppNotSupportedAfterDays(String numberOfDays) {
    return 'يجب تحديث هذا الإصدار من التطبيق في **خلال $numberOfDays**.\n\nهل تريد التحديث إلى الإصدار الأحدث؟';
  }

  @override
  String get later => 'لاحقاً';

  @override
  String get updateApp => 'تحديث التطبيق؟';

  @override
  String newVersionOfTheAppIsAvailable(
      String latestAppVersion, String currentAppVersion) {
    return 'نسخة جديدة من التطبيق متاحة! الإصدار $latestAppVersion متوفر الآن - لديك $currentAppVersion\n\nهل ترغب في تحديثه الآن؟';
  }

  @override
  String get resetToDefault => 'إعادة إلى الوضع الافتراضي';

  @override
  String get theme => 'السمات';

  @override
  String get systemDefault => 'تلقائياً مع النظام';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'مظلم';

  @override
  String get language => 'اللغة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get changeToLightMode => 'التغيير إلى الوضع الفاتح';

  @override
  String get changeToDarkMode => 'التغيير إلى الوضع المظلم';

  @override
  String get speakSearchResult => 'نطق نتيجة البحث';

  @override
  String get alwaysSpeak => 'تحدث دائما';

  @override
  String get whenVoiceSearch => 'عند البحث الصوتي';

  @override
  String get neverSpeak => 'لا تتحدث أبدا';

  @override
  String get selectALanguageToUseVoiceSearch => 'حدد لغة لاستخدام البحث الصوتي';

  @override
  String get voiceSearchLanguage => 'لغة البحث الصوتي';

  @override
  String get defaultWord => 'تلقائياً';

  @override
  String get allLanguages => 'كل اللغات';

  @override
  String get appOverview => 'نظرة عامة';

  @override
  String get appOverviewdetailed =>
      '**تطبيق التوعية بسرطان الثدي** هو أداة شاملة مصممة لزيادة الوعي وتعزيز الكشف المبكر عن سرطان الثدي. ويتناول أربعة جوانب رئيسية: توفير `المعلومات والتوعية`، وتسهيل `الفحص الذاتي` من خلال أداة فحص الأعراض، ومساعدة الأطباء من خلال `نماذج التعلم العميق` للكشف، وتقديم `مصادر` الدعم و`التوجيه` للمرضى.\n* **الغرض:** تم إنشاء التطبيق بهدف أساسي هو تمكين الأفراد من تولي مسؤولية صحة الثدي. من خلال دمج المعلومات وأدوات الفحص الذاتي ونماذج الكشف المتقدمة والمصادر الداعمة، نهدف إلى المساهمة في الكشف المبكر عن سرطان الثدي وإدارته.\n* **الجمهور المستهدف:** يمتد جمهورنا المستهدف على نطاق واسع، بما في ذلك الأفراد من جميع الأجناس المهتمين بالتوعية بصحة الثدي، والذين يقومون بالفحوصات الذاتية، والأطباء الأخصائيين الذين يبحثون عن أدوات تشخيصية متقدمة، والمرضى الذين يحتاجون إلى الدعم والتوجيه.\n\n**الميزات الرئيسية**\n* **مركز المعلومات: ** معلومات يمكن الوصول إليها عن سرطان الثدي وأعراضه وعوامل الخطر والتدابير الوقائية.\n* **مدقق الأعراض:** أداة فحص ذاتي تفاعلية توجه المستخدمين خلال عملية اكتشاف الأعراض المحتملة.\n* **نماذج التعلم العميق:** نماذج ذكاء اصطناعي متقدمة للأطباء، تساعد في الكشف عن سرطان الثدي من خلال صور الأشعة السينية للثدي والنسيجي (هيستوباثولوجي).\n* **دعم المرضى:** توجيه التغذية والنظام الغذائي وممارسة التمارين الرياضية ، بالإضافة إلى برنامج chatbot الذي يوفر الإجابات والإرشادات من خلال إمكانيات تحويل النص إلى كلام وتحويل الكلام إلى نص.\n\n**البيانات والأبحاث**\n* **تطبيق التوعية بسرطان الثدي ** مبني على أساس البحث والتعاون مع الأطباء والأخصائيين. لقد قمنا بدمج رؤى من الدراسات العلمية واستشارة خبراء في هذا المجال لتطوير نماذج التعلم العميق. يتم تنظيم محتوى التطبيق بناءً على معلومات قائمة وموثوقة لضمان الدقة والإعتمادية.\n\n**الخصوصية و معلومات الإتصال**';

  @override
  String get contactUs => 'تواصل معنا عبر هذا البريد الإلكتروني';

  @override
  String get app => '';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الإستخدام';

  @override
  String get somethingWentWrongPleaseTryAgainLater =>
      'حدث خطأ ما ، الرجاء المحاولة في قت لاحق';

  @override
  String get errorHappendThereIsNoDataForThatAccount =>
      'حدث خطأ، لا توجد بيانات لهذا الحساب';

  @override
  String get unexpectedErrorHappened => 'حدث خطأ غير متوقع.';

  @override
  String get userNotFoundForThatEmail =>
      'لم يتم العثور على المستخدم لهذا البريد الإلكتروني.';

  @override
  String get emailNotValid => 'البريد الإلكتروني غير صالح.';

  @override
  String get thePasswordIsWrong => 'كلمة المرور خاطئة.';

  @override
  String get theUserIsNotFoundForThatEmailOrThePasswordIsWrong =>
      'لم يتم العثور على المستخدم لهذا البريد الإلكتروني أو كلمة المرور خاطئة.';

  @override
  String get theProvidedPasswordIsWeakTryToPutAStrongPassword =>
      'كلمة المرور المقدمة ضعيفة حاول وضع كلمة مرور قوية.';

  @override
  String get theProvidedEmailAlreadyExistsSignInInsteadOrProvideAnotherEmail =>
      'البريد الإلكتروني المقدم موجود بالفعل، قم بتسجيل الدخول بدلاً من ذلك أو قم بتقديم بريد إلكتروني آخر.';

  @override
  String noProviderNameAccountWasSelected(String provider) {
    return 'لم يتم اختيار حساب $provider !!!';
  }

  @override
  String anAccountAlreadyExistsWithTheSameEmailAddressAsYourProviderAccount(
      String providerName) {
    return 'يوجد حساب بالفعل بنفس عنوان البريد الإلكتروني لحساب $providerName.\nقم بتسجيل الدخول باستخدام الحساب المقترن بعنوان البريد الإلكتروني هذا.';
  }

  @override
  String youSelectedADifferentProviderAccount(String providerName) {
    return 'لقد حددت حساب $providerName مختلفًا.\nحدد حساب $providerName الذي قمت بتسجيل الدخول إليه باستخدام التطبيق. أو قم بإعادة تسجيل الدخول إلى التطبيق بدلاً من ذلك.';
  }

  @override
  String get somethingWentWrong => 'حدث خطأ ما!!';

  @override
  String get youAreAGuest => 'أنت ضيف ولم تسجل حساب بعد';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get facebook => 'فيسبوك';

  @override
  String get twitter => 'تويتر';

  @override
  String get x => 'إكس';

  @override
  String get google => 'جوجل';

  @override
  String emailOfYourProviderAccount(String providerName) {
    return 'البريد الإلكتروني لحساب $providerName الخاص بك';
  }

  @override
  String get fullName => 'الإسم بالكامل';

  @override
  String get noPhoneNumberProvided => 'لا يوجد رقم هاتف';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get doctor => 'طبيب';

  @override
  String get patient => 'مريض';

  @override
  String get normal => 'عادي';

  @override
  String get userType => 'نوع المستخدم';

  @override
  String userOf(String userType) {
    return 'مستخدم $userType';
  }

  @override
  String joinedIn(String dateOfSignUp) {
    return 'تم الانضمام في $dateOfSignUp';
  }

  @override
  String get editProfile => 'تعديل الحساب الشخصي';

  @override
  String get deleteAccount => 'حذف الحساب الخاص بي';

  @override
  String get dangerousArea => 'منطقة خطر';

  @override
  String get areYouSureOfDeletingYourAccount =>
      '* هل أنت متأكد من **حذف حسابك؟** سيتم حذف كافة البيانات والمعلومات. **لا يمكن التراجع عن ذلك.**\n* قد يُطلب منك **تأكيد** بياناتك للتأكد من هويتك.';

  @override
  String get delete => 'حذف';

  @override
  String get pleaseEnterYourPasswordToConfirm =>
      'الرجاء إدخال كلمة المرور الخاصة بك لتأكيد حذف حسابك.';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordMustBeAtLeast8CharactersLong =>
      'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل.';

  @override
  String get save => 'حفظ';

  @override
  String get someFieldsAreEmpty => 'بعض الحقول فارغة.';

  @override
  String get pleaseEnterAValidPhoneNumber => 'يرجى إدخال رقم هاتف صالح.';

  @override
  String get selectImage => 'اختر صورة';

  @override
  String get changeImage => 'تغيير الصورة';

  @override
  String get clearTheImage => 'إزالة الصورة';

  @override
  String get firstName => 'الإسم الأول';

  @override
  String get lastName => 'الإسم الأخير';

  @override
  String get pleaseEnterTheFirstName => 'الرجاء إدخال الاسم الأول.';

  @override
  String get pleaseEnterTheLastName => 'الرجاء إدخال الاسم الأخير.';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get pleaseSignInToContinue => 'قم بتسجيل الدخول للمتابعة';

  @override
  String get pleaseEnterAValidEmailAddress =>
      'يرجى إدخال عنوان بريد إلكتروني صالح.';

  @override
  String get forgotPassword => 'هل نسيت كلمة السر؟';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟ ';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get or => 'أو';

  @override
  String get signUpLater => 'إنشاء حساب لاحقاً؟ ';

  @override
  String get continueAsGuest => 'الاستمرار كضيف';

  @override
  String signInUsingProviderAccount(String provider) {
    return 'قم بتسجيل الدخول باستخدام حساب $provider.';
  }

  @override
  String get forgotYourPassword => 'هل نسيت كلمة السر؟';

  @override
  String get putYourEmailToSendALinkForResettingYourPassword =>
      'أدخل بريدك الإلكتروني لإرسال رابط لإعادة تعيين كلمة المرور الخاصة بك.';

  @override
  String get followUp => 'متابعة';

  @override
  String get finishedResetting => 'تم الانتهاء من إعادة الضبط';

  @override
  String get sendResetRequest => 'إرسال طلب إعادة تعيين';

  @override
  String checkYourInboxForAnEmailThatHasJustBeenSent(String userEmail) {
    return '* تحقق من **البريد الوارد** بحثًا عن رسالة بريد إلكتروني تم إرسالها للتو إلى $userEmail.\n* اتبع **الرابط** وأعد تعيين كلمة المرور.\n* عند **الانتهاء**، ارجع إلى التطبيق وقم بتسجيل الدخول باستخدام كلمة المرور الجديدة.';
  }

  @override
  String get createAnAccount => 'إنشاء حساب';

  @override
  String get pleaseEnterAValidName => 'رجاء ادخل اسما صحيحا.';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get emptyFieldPleaseConfirmThePassword =>
      'حقل فارغ، الرجاء تأكيد كلمة المرور.';

  @override
  String get thosePasswordsDidntMatchTryAgain =>
      'كلمات المرور غير متطابقة. حاول ثانية.';

  @override
  String get alreadyHaveAnAccount => 'هل لديك حساب بالفعل ؟ ';

  @override
  String get selectUserType => 'حدد نوع المستخدم';

  @override
  String get skipForNow => 'تخطي';

  @override
  String get continueToMainScreen => 'المتابعة';

  @override
  String get hello => 'أهلاً';

  @override
  String get youUnderstandThatEveryDayCountsWhenItComesToEarlyBreastCancerDetection =>
      'أنت تدرك أن كل يوم مهم عندما يتعلق الأمر بالكشف المبكر عن سرطان الثدي. من الرائع أن تتحمل مسؤولية صحتك وتقوم بفحص الثدي بانتظام.';

  @override
  String get selfCheckNow => 'فحص-ذاتي الان';

  @override
  String get myBreastCheckHistory => 'سجل الفحص الذاتي';

  @override
  String get breastCancerAwarenessandwhy =>
      'التوعية بسرطان الثدي\nو\nلماذا يعد الكشف المبكر مهمًا';

  @override
  String get learnMore => 'المزيد';

  @override
  String get description => 'الوصف';

  @override
  String get notAbleToSaveFilesToLocalDeviceStorage =>
      'غير قادر على حفظ الملفات على مساحة تخزين الجهاز المحلي.';

  @override
  String get notAbleToDeleteFilesFromLocalDeviceStorage =>
      'غير قادر على حذف الملفات من مساحة تخزين الجهاز المحلي.';

  @override
  String get deleteAllSelfchecks => 'حذف كافة الفحوصات الذاتية';

  @override
  String get mySelfchecks => 'فحوصاتي الذاتية';

  @override
  String get warning => 'تحذير';

  @override
  String get deleteAll => 'حذف الكل';

  @override
  String get fromLeftToRight => 'من اليسار إلى اليمين';

  @override
  String get fromRightToLeft => 'من اليمين إلى اليسار';

  @override
  String areYouSureOfDeletingAllYourSelfchecks(String textDirection) {
    return '* هل أنت متأكد من **حذف كافة الفحوصات الذاتية؟** سيتم حذف كافة البيانات ومعلومات الملاحظات.\n* إذا كنت تريد حذف ملاحظة معينة، **اسحبها** $textDirection.';
  }

  @override
  String get textNote => 'ملاحظة نصية';

  @override
  String get voiceNote => 'ملاحظة صوتية';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String get confirmDeletion => 'تأكيد الحذف؟';

  @override
  String get noActivityYet => 'لا يوجد نشاط بعد';

  @override
  String get selfcheck => 'فحص ذاتي';

  @override
  String get letYourselfBeGuidedByTextAndGraphicsStepByStep =>
      'اتبع التوجيهات بدقة مع النصوص والرسوم التوضيحية خطوة بخطوة.';

  @override
  String get startSelfcheck => 'بدء الفحص الذاتي';

  @override
  String get whatShouldILookFor => 'ما يجب أن أبحث عنه؟';

  @override
  String get whatToLookFor => 'ما يجب البحث عنه';

  @override
  String get lumpsKnotsThickenings => 'التكتلات، العقد، التضخمات';

  @override
  String get changesInSizeOrShape => 'تغييرات في الحجم أو الشكل';

  @override
  String get nippleDischarge => 'إفرازات من الحلمة';

  @override
  String get skinChanges => 'تغييرات في الجلد';

  @override
  String get lumpsKnotsThickeningsDetails =>
      'يمكن أن تكون الكتل أو العقد المتصلبة أو السُمك في أنسجة الثدي علامة على الإصابة بسرطان الثدي. يمكن أن تحدث تحت الجلد مباشرةً، أو في منتصف الثدي، أو في الأنسجة العميقة بالقرب من العظام.';

  @override
  String get changesInSizeOrShapeDetails =>
      'التغييرات غير المعتادة في الحجم أو الشكل يجب فحصها. الأمر نفسه صحيح بالنسبة للتشوهات أو التورمات. تذكر أن صدرك الأيسر والأيمن قد يبدوان مختلفين. اعرف ما هو طبيعي بالنسبة لك.';

  @override
  String get nippleDischargeDetails =>
      'يجب أن تبدو الحلمة طبيعية بالنسبة لك، ويجب أن تكون خالية من التهيج. التحقق من وجود إفرازات غير عادية للسوائل أو الدم';

  @override
  String get skinChangesDetails =>
      'يجب ألا يكون هناك تجاعيد أو انتفاخ غريب في الجلد. قم بإجراء فحص إذا كان هناك أي احمرار أو ألم أو طفح جلدي مستمر، خاصة إذا كان على جانب واحد فقط.';

  @override
  String pageOf(int numPage, int numPages) {
    return '$numPage من $numPages';
  }

  @override
  String get thisIsTheFirstStep => 'هذه هي الخطوة الأولى';

  @override
  String get previousStep => 'الخطوة السابقة';

  @override
  String get endSelfcheck => 'انهِ الفحص الذاتي';

  @override
  String get nextStep => 'الخطوة التالية';

  @override
  String get switchToMirror => 'انتقل إلى المرآة';

  @override
  String get start => 'ابدأ';

  @override
  String get look => 'انظر';

  @override
  String get feel => 'اشعر';

  @override
  String get circles => 'دوائر';

  @override
  String get armpit => 'إبط';

  @override
  String get nipple => 'حلمة';

  @override
  String get lieDown => 'استلقِ';

  @override
  String get helpfulHintShower => 'تلميح مفيد: استحم';

  @override
  String get startDetails =>
      'ابدأ في وضعٍ مستقيم، يديك على وسطك. انظر إلى ثدييك بمساعدة مرآة، هاتفك المحمول، أو صديق.';

  @override
  String get lookDetails =>
      'هل ترى أي تغييرات في الحجم أو الشكل أو اللون؟ تورم؟ تجعد الجلد؟ ارفع ذراعيك وتحقق مرة أخرى.';

  @override
  String get feelDetails =>
      'استخدم أطراف أصابعك واشعر بثديك. اتبع النمط. تحسس الكتل والعقد المتصلبة والسماكة.';

  @override
  String get circlesDetails =>
      'احتفظ بأصابعك معًا ومسطحة. حرك بحركات دائرية صغيرة. كرر باستخدام ضغط خفيف، ثم متوسط، ثم قوي. مع الضغط القوي، يجب أن تشعر بقفص صدرك.';

  @override
  String get armpitDetails =>
      'قم بتغطية كامل المنطقة حتى الإبط. اليد اليسرى تشعر بالجانب الأيمن واليد اليمنى تشعر بالجانب الأيسر.';

  @override
  String get nippleDetails => 'عصر الحلمة. هل هناك أي إفرازات غير عادية؟';

  @override
  String get lieDownDetails =>
      'استلقِ بحيث ينتشر النسيج بشكل متساوٍ. كرر فحص ثدييك.';

  @override
  String get helpfulHintShowerDetails =>
      'يمكنك القيام بفحص نفسك تحت الدش. في بعض الأحيان يكون الأمر أسهل عندما يكون الثدي رطبًا وملئ برغاوي الصابون.';

  @override
  String get findings => 'النتائج';

  @override
  String get congratulationsItsGreatThatYouAreTakingCareOfYourHealth =>
      'تهانينا! من الرائع أن تهتم بصحتك.';

  @override
  String get allIsWell => 'كل شيء على ما يرام';

  @override
  String get notSure => 'غير متأكد';

  @override
  String get noticedSomething => 'لاحظت شيئًا';

  @override
  String get yourReminderHasBeenSet => 'تم ضبط تذكيرك:';

  @override
  String doYouWantToBeRemindedToCheckAgainIn(String durationInString) {
    return 'هل ترغبين في أن يتم تذكيرك بالفحص مرة أخرى بعد $durationInString؟';
  }

  @override
  String get yourNextSelfcheckIsDue => 'الفحص الذاتي التالي قد حان.';

  @override
  String get dontWorry => 'لا تقلقِ';

  @override
  String get nextReminder => 'التذكير التالي';

  @override
  String get ifYouNoticedAnythingUnusualWhenExaminingYourBreasts =>
      'إذا لاحظتِ أي شيء غير عادي عند فحص ثدييكِ، فابقي هادئة! قومي بفحص المنطقة مرة أخرى بعد الدورة الشهرية القادمة. إذا استمر التغيير، يجب عليكِ رؤية الطبيب.\n\n';

  @override
  String get youWillAutomaticallyBeReminded =>
      'سيتم تذكيرك تلقائيًا بالفحص التالي الخاص بك.\n\nهذا سيكون في:';

  @override
  String get addNotes => 'إضافة ملاحظات';

  @override
  String get finish => 'إنهاء';

  @override
  String get enterATextNote => 'أكتب ملاحظة نصية';

  @override
  String get microphonePermissionIsNeededToRecordAVoiceNote =>
      'الإذن مطلوب لتسجيل ملاحظة صوتية.';

  @override
  String get recording => 'جارِ التسجيل';

  @override
  String get pickAMedicalImageOfBreastCancerMammogramXrayOrHistologyOfThePatient =>
      'اختر صورة طبية لسرطان الثدي، سواء كانت صورة الأشعة السينية (الماموغرام) أو لأنسجة المريض (هيستولوجي).';

  @override
  String get seeTheResultOrPredictionUsingTheDeepLearningModels =>
      'إطلع إلى النتيجة أو التوقع باستخدام نماذج التعلم العميق.';

  @override
  String get caution => 'الحذر';

  @override
  String get thisAiModelsAreToolsForAssistingMedicalProfessionals =>
      'تعد `نماذج الذكاء الاصطناعي` هذه أدوات لمساعدة المتخصصين في المجال الطبي ويجب استخدامها فقط من قبل `المتخصصين المدربين`. وهو `ليس بديلاً` عن الحكم الطبي أو التشخيص أو العلاج المتخصص. \n* **يُرجى العلم** أن التنبؤات التي تقدمها هذه النماذج ليست دقيقة بنسبة 100 بالمائة، ولا ينبغي الاعتماد عليها فقط في اتخاذ القرارات الطبية. استشر دائمًا مقدم رعاية صحية مؤهل أو أخصائي سرطان الثدي لإجراء تقييم وتشخيص شاملين. \n* **قد يؤدي استخدام هذا النموذج دون إشراف الخبراء** إلى استنتاجات غير صحيحة ونتائج ضارة محتملة. إن صحتك وعافيتك لهما أهمية قصوى، وتهدف نماذج الذكاء الاصطناعي هذه إلى استكمال خبرة المتخصصين الطبيين، وليس استبدالها. \n* **يُرجى توخي الحذر والتقدير** عند تفسير النتائج الناتجة عن نماذج الذكاء الاصطناعي هذه وطلب التوجيه من أخصائي رعاية صحية مؤهل بشأن أي مخاوف تتعلق بسرطان الثدي أو صحتك العامة.';

  @override
  String get youDidntProvideAnImage => 'عذراً، لم تقدم صورة!!!';

  @override
  String get youHaveToSignInToContinue => 'يجب عليك تسجيل الدخول للمتابعة!!';

  @override
  String get sorry => 'عذرًا';

  @override
  String get thisFeatureOnlyAvailableToDoctors =>
      'هذه الميزة متاحة فقط للأطباء.';

  @override
  String get hideImageBoxAbove => 'إخفاء مربع الصورة أعلاه';

  @override
  String get showImageBox => 'عرض مربع الصورة';

  @override
  String get showResult => 'عرض النتيجة';

  @override
  String get selectMedicalImageType => 'حدد نوع الصورة الطبية';

  @override
  String get xrayImage => 'صورة الأشعة السينية';

  @override
  String get histologyImage => 'صورة الأنسجة هيستولوجي';

  @override
  String get select => 'اختيار';

  @override
  String get openCamera => 'فتح الكاميرا';

  @override
  String get pickAnImage => 'اختيار صورة';

  @override
  String get orPasteALinkHere => 'أو قم بلصق الرابط هنا';

  @override
  String get youDidntReadQrCode => 'لم تقم بقراءة رمز (QR Code)';

  @override
  String get errorHappenedWhileTryingToOpenQrCodeScanner =>
      'حدث خطأ أثناء محاولة فتح ماسح رمز (QR Code)';

  @override
  String get getImageLinkByReadingQrCode =>
      'احصل على رابط الصورة عن طريق قراءة (QR Code)';

  @override
  String get itMayTakeAWhileTheModelIsGettingDownloaded =>
      'قد يستغرق الأمر بعض الوقت، يتم تنزيل أو تحديث النموذج.';

  @override
  String get normalLabel => 'طبيعي';

  @override
  String get cancerLabel => 'سرطان';

  @override
  String get aboveNinety => 'تتجاوز 90';

  @override
  String predictionOf(String imageType) {
    return 'توقع $imageType';
  }

  @override
  String predictionWithConfidence(String prediction, String confidence) {
    return '$prediction بنسبة ثقة $confidence%';
  }

  @override
  String get sorryThereIsNoResultForYourSearch =>
      'عذرًا، لا توجد نتائج لبحثك، تم تصفية النتيجة.';

  @override
  String get sorryThereIsNoResultForYourSearchWithDetails =>
      '**عذرًا، لا توجد نتائج لبحثك**\n\n* تمت تصفية النتيجة.\n* أو أنك تبحث باستخدام **لغة** غير مدعومة حالياً.';

  @override
  String get tipsForYourVisitToTheDoctor => 'نصائح لزيارتك للطبيب';

  @override
  String get tipsForYourVisitToTheDoctorDetails =>
      'نصائح للأشياء التي يمكنك قولها وفعلها في موعدك مع الطبيب.';

  @override
  String get searchAboutBreastCancer => 'البحث حول سرطان الثدي';

  @override
  String get searchAboutBreastCancerDetails =>
      'ابحث عن معلومات أو اسأل الذكاء الاصطناعي للإرشاد.';

  @override
  String get cancerNutrition => 'السرطان والتغذية';

  @override
  String get cancerNutritionDetais =>
      'معلومات وإرشادات للحفاظ على نظام غذائي صحي أثناء علاج السرطان.';

  @override
  String get exercisePhysicalActivity => 'التمرين والنشاط البدني';

  @override
  String get exercisePhysicalActivityDetais =>
      'ممارسة التمارين الرياضية بانتظام والنشاط البدني أمر ضروري.';

  @override
  String get otherResources => 'مصادر أخرى';

  @override
  String get otherResourcesDetails =>
      'ألق نظرة على بعض المصادر المفيدة الأخرى.';

  @override
  String get tipsForYourDoctorsVisit => 'نصائح لزيارتك للطبيب';

  @override
  String get tipsForThingsToSayDoAtYourDoctorsAppointment =>
      'نصائح حول ما يجب قوله وفعله أثناء موعدك مع طبيبك.\n\nتذكر أننا لسنا متخصصين في المجال الطبي ولكننا هنا لدعمك. فيما يلي بعض النصائح حول الأشياء التي يجب أن تقولها وتفعلها في موعدك، ولكننا نشجعك على إجراء المزيد من البحث.\n\n';

  @override
  String get weWantToHelpProvideYouWithToolsToBeYourOwnHealthAdvocatenn =>
      'نريد مساعدتك في تزويدك بالأدوات اللازمة لتكون مدافعًا عن صحتك.\n\n';

  @override
  String get haveYourAppHandyToReferenceYourNotes =>
      'اجعل تطبيقك في متناول يديك للرجوع إلى ملاحظاتك في عيادة الطبيب. من الجيد دائمًا أن تكون المعلومات مكتوبة، بحيث لا تنسى أي شيء مهم.\n';

  @override
  String get bringSomeoneWithYouToTakeNotesOrAskYourDoctor =>
      'أحضر معك شخصًا لتدوين الملاحظات أو اسأل طبيبك إذا كان بإمكانك تسجيل مناقشتك حتى تحصل على جميع المعلومات. إن وجود شخص ما هناك يمكن أن يساعد في ضمان الإجابة على جميع أسئلتك، أو المساعدة في التحدث بالنيابة عنك، إذا لزم الأمر.\n';

  @override
  String get askForPamphletsAndForTheirNotesToBePrintedOut =>
      'اطلب طباعة الكتيبات وملاحظاتهم أو إرسالها إليك عبر البريد الإلكتروني، إذا لم يتم ذلك تلقائيًا. احصل على أكبر قدر ممكن من المعلومات.\n';

  @override
  String get beEmpoweredToGetASecondOpinion =>
      'لا تتردد في الحصول على رأي ثانٍ. هناك الكثير من الأسباب التي تجعل هذه فكرة جيدة. يجب أن تكون مرتاحًا مع الشخص الذي تعمل معه وتشخيصه وعلاجه - إذا كان هناك شيء يجب علاجه. قد يتمكن طبيبك من إحالتك إلى شخص آخر للحصول على رأي ثانٍ.\n';

  @override
  String get tipsForTranslation => 'نصائح للترجمة';

  @override
  String get showTips => 'عرض نصائح';

  @override
  String get gifToExplainTheAbove => 'GIF لشرح ما ورد أعلاه';

  @override
  String get errorHappenedCouldntLoadTheGif => 'حدث خطأ، تعذر تحميل ملف GIF';

  @override
  String get accessChromeMenuInstructions =>
      '* **الدخول إلى قائمة Chrome:** في الزاوية العلوية اليسرى أو اليمنى، ستجد ثلاث نقاط (القائمة). انقر عليها لفتح القائمة.\n* **حدد \"ترجمة\":** ابحث عن خيار \"ترجمة\" في القائمة. انقر عليها.\n* **تمكين الترجمة:** قم بتبديل المفتاح لتمكين الترجمة لموقع الويب. سيكتشف Chrome تلقائيًا لغة صفحة الويب ويسألك عما إذا كنت تريد ترجمتها.\n* **تأكيد الترجمة:** ستظهر نافذة منبثقة تسألك عما إذا كنت تريد ترجمة الصفحة. اضغط على \"ترجمة\" للتأكيد.';

  @override
  String get takeALookAtSomeOtherHelpfulResources =>
      'ألقِ نظرة على بعض المصادر المفيدة الأخرى\n ';

  @override
  String get support => 'الدعم: ';

  @override
  String get youngSurvivalCoalition => 'تحالف البقاء على قيد الحياة للشباب\n ';

  @override
  String get treatment => 'العلاج: ';

  @override
  String get breastCancerTreatment => 'علاج سرطان الثدي\n ';

  @override
  String get childrenTreatment => 'علاج الأطفال: ';

  @override
  String get childhoodBreastCancerTreatment => 'علاج سرطان الثدي في الطفولة\n ';

  @override
  String get duringPregnancy => 'خلال الحمل: ';

  @override
  String get breastCancerTreatmentDuringPregnancy =>
      'علاج سرطان الثدي أثناء الحمل\n ';

  @override
  String get forMales => 'للذكور: ';

  @override
  String get maleBreastCancerTreatment => 'علاج سرطان الثدي للذكور\n ';

  @override
  String get screening => 'الفحص: ';

  @override
  String get breastCancerScreening => 'فحص سرطان الثدي\n ';

  @override
  String get askAi => 'اسأل الذكاء الاصطناعي';

  @override
  String get googleSearch => 'بحث جوجل';

  @override
  String get googleScholar => 'الباحث العلمي';

  @override
  String get wikipediaSearch => 'بحث ويكيبيديا';

  @override
  String get search => 'بحث';

  @override
  String get thisAppProvidesInformationAndAssistanceRelatedToMedicalTopics =>
      'يوفر هذا التطبيق المعلومات والمساعدة المتعلقة بالموضوعات `الطبية` باستخدام `الذكاء الاصطناعي` و`المصادر عبر الإنترنت`. ومع ذلك، فهو ليس بديلاً عن المشورة الطبية المتخصصة أو التشخيص أو العلاج. يرجى قراءة ومراعاة ما يلي:\n\n* **استشر أحد متخصصي الرعاية الصحية:** إذا كنت تعاني من حالة طبية أو أعراض أو مخاوف بشأن صحتك، فاستشر مقدم رعاية صحية مؤهل. لا يحل هذا التطبيق محل خبرة المتخصصين في المجال الطبي.\n* **الاستخدام كمكمل:** استخدم هذا التطبيق كأداة تكميلية لجمع معلومات عامة حول المواضيع الطبية. يمكن أن يقدم رؤى واقتراحات ولكن لا ينبغي أن يكون المصدر الوحيد لتوجيهات الرعاية الصحية.\n* **ليس لحالات الطوارئ:** في حالات الطوارئ الطبية، اتصل برقم الطوارئ المحلي أو اطلب رعاية طبية فورية. هذا التطبيق غير مُجهز للتعامل مع المواقف العاجلة.\n* **تحقق من المعلومات:** تحقق دائمًا من المعلومات التي تتلقاها في هذا التطبيق من خلال مصادر طبية أو متخصصين موثوقين. تتطور المعرفة الطبية، وقد لا تعكس المعلومات المقدمة هنا دائمًا أحدث الإرشادات.\n* **مسؤولية المستخدم:** صحتك هي مسؤوليتك. لا تتخذ قرارات طبية بناءً على المعلومات التي تم الحصول عليها من هذا التطبيق فقط.';

  @override
  String get selectSearchType => 'اختر نوع البحث';

  @override
  String get searchWithYourVoice => 'البحث بصوتك';

  @override
  String get breastCancerSymptoms => 'أعراض سرطان الثدي';

  @override
  String get breastCancerStages => 'مراحل سرطان الثدي';

  @override
  String get breastCancerTreatmentOptions => 'خيارات علاج سرطان الثدي';

  @override
  String get breastCancerSupportGroups => 'مجموعات دعم سرطان الثدي';

  @override
  String get breastCancerSurvivorStories => 'قصص الناجين من سرطان الثدي';

  @override
  String get breastCancerResearch => 'أبحاث سرطان الثدي';

  @override
  String get breastCancerAwareness => 'التوعية بسرطان الثدي';

  @override
  String get breastCancerOrganizations => 'منظمات مكافحة سرطان الثدي';

  @override
  String get breastCancerDietAndNutrition => 'نظام غذائي وتغذية لسرطان الثدي';

  @override
  String get breastCancerExerciseAndFitness =>
      'تمارين ولياقة بدنية لسرطان الثدي';

  @override
  String get breastReconstruction => 'إعادة بناء الثدي';

  @override
  String get breastCancerSideEffects => 'آثار جانبية لسرطان الثدي';

  @override
  String get breastCancerMedications => 'أدوية سرطان الثدي';

  @override
  String get breastCancerFinancialSupport => 'دعم مالي لسرطان الثدي';

  @override
  String get breastCancerMentalHealth => 'الصحة النفسية لسرطان الثدي';

  @override
  String get breastCancerScreeningGuidelines => 'إرشادات فحص سرطان الثدي';

  @override
  String get breastCancerInMen => 'سرطان الثدي عند الرجال';

  @override
  String get breastCancerRiskFactors => 'عوامل الخطر لسرطان الثدي';

  @override
  String get breastCancerFamilyHistory => 'تاريخ عائلي لسرطان الثدي';

  @override
  String get breastCancerPrevention => 'الوقاية من سرطان الثدي';

  @override
  String get yourSearchDidNotMatchAnyResultsWithDetails =>
      '**لم يطابق بحثك أية نتائج**\n\n* تأكد من كتابة جميع الكلمات بشكل صحيح أو جرّب كلمات مفتاحية مختلفة.\n* أو أنك تبحث باستخدام **لغة** غير مدعومة حالياً.';

  @override
  String get articles => 'مقالات علمية';

  @override
  String get microphonePermissionIsNeededToSearchWithYourVoice =>
      'إذن الوصول إلى الميكروفون مطلوب للبحث بصوتك.';

  @override
  String get microphoneOffTryAgain => 'الميكروفون مغلق. حاول مرة أخرى.';

  @override
  String get didntHearThatTryAgain => 'لم يتم سماع ذلك. حاول مرة أخرى.';

  @override
  String get listening => 'جاري الاستماع...';

  @override
  String get tapTheMicrophoneToTryAgain =>
      'اضغط على الميكروفون للمحاولة مرة أخرى';

  @override
  String get speechNotAvailable => 'التعرف على الكلام غير متاح';
}
