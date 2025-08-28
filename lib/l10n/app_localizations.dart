import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('tr'),
  ];

  /// the english language word
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// the arabic language word
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// the spanish language word
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// the frensh language word
  ///
  /// In en, this message translates to:
  /// **'Frensh'**
  String get frensh;

  /// the german language word
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// the turkish language word
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get turkish;

  /// the ok word
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// the back word `for backArrow icon tooltip`
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// the Error word
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// the Please Choose word
  ///
  /// In en, this message translates to:
  /// **'Please Choose'**
  String get pleaseChoose;

  /// the Camera word
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// the Gallery word
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// the Share word
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// the error if Trying To Share did not complete
  ///
  /// In en, this message translates to:
  /// **'An error happened while trying to share the image.'**
  String get errorHappenedWhileTryingToShareTheImage;

  /// the Save to gallery word
  ///
  /// In en, this message translates to:
  /// **'Save to gallery'**
  String get saveToGallery;

  /// the image saved to gallery word, basicly in imageScreen of imageContainer
  ///
  /// In en, this message translates to:
  /// **'Image saved to gallery'**
  String get imageSavedToGallery;

  /// the error if Trying To save to gallery did not complete
  ///
  /// In en, this message translates to:
  /// **'An error happened while saving the image to the gallery.'**
  String get errorHappenedWhileSavingTheImage;

  /// the Attention word
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// the response if you pressed the system navigation back button ON the scope of homeScreen
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit?'**
  String get doYouWantToExit;

  /// the Exit word
  ///
  /// In en, this message translates to:
  /// **' Exit '**
  String get exit;

  /// the Cancel word
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// the Copy code word, for code container
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get copyCode;

  /// the Copid! word
  ///
  /// In en, this message translates to:
  /// **'Copid!'**
  String get copid;

  /// the km word
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// the meter word
  ///
  /// In en, this message translates to:
  /// **'meter'**
  String get meter;

  /// the response if `web link` is not valid
  ///
  /// In en, this message translates to:
  /// **'Link is Not valid'**
  String get linkIsNotvalid;

  /// the response if no internet connections
  ///
  /// In en, this message translates to:
  /// **'You are currently offline'**
  String get youAreCurrentlyOffline;

  /// the response if the linke is valid but not resolve as an image
  ///
  /// In en, this message translates to:
  /// **'Link doesn\'t point to an image'**
  String get linkDoesnotPointToImage;

  /// the response if `password formField in SignUp screen` is empty or less than 8 characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long, with at least 5 alphabet, 2 numbers, and 1 special character like '**
  String get passwordMustBeAtLeastWithDetails;

  /// one of possible errors in `password formField in SignUp screen`
  ///
  /// In en, this message translates to:
  /// **'5 alphabet characters'**
  String get fiveAlphabetCharacters;

  /// one of possible errors in `password formField in SignUp screen`
  ///
  /// In en, this message translates to:
  /// **'2 numbers'**
  String get twoNumbers;

  /// one of possible errors in `password formField in SignUp screen`
  ///
  /// In en, this message translates to:
  /// **'1 special charachters like '**
  String get oneSpecialCharachtersLike;

  /// one of possible errors in `password formField in SignUp screen`
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least'**
  String get passwordMustContainAtLeast;

  /// the comma seperator `,`
  ///
  /// In en, this message translates to:
  /// **', '**
  String get comma;

  /// the and word
  ///
  /// In en, this message translates to:
  /// **'And '**
  String get and;

  /// the Today word
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// the Yesterday word
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// the at word `for clocks` like **at 10:33 PM**
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get at;

  /// the just now word
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// used for duration ago like: `3 years ago`
  ///
  /// In en, this message translates to:
  /// **'{durationInString} ago'**
  String durationAgo(String durationInString);

  /// used for duration from now like: `3 years from now`
  ///
  /// In en, this message translates to:
  /// **'{durationInString} from now'**
  String durationFromNow(String durationInString);

  /// the second word
  ///
  /// In en, this message translates to:
  /// **'second'**
  String get second;

  /// the 2 seconds word
  ///
  /// In en, this message translates to:
  /// **'2 seconds'**
  String get twoSeconds;

  /// number of seconds between 3 and 10 like: 3, 5 or 10 seconds
  ///
  /// In en, this message translates to:
  /// **'{numberOfSeconds} seconds'**
  String secondsBeteenThreeAndTen(int numberOfSeconds);

  /// number of seconds more than 10 like: 11 seconds
  ///
  /// In en, this message translates to:
  /// **'{numberOfSeconds} seconds'**
  String secondsMoreThanTen(int numberOfSeconds);

  /// the minute word
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// the 2 minutes word
  ///
  /// In en, this message translates to:
  /// **'2 minutes'**
  String get twoMinutes;

  /// number of minutes between 3 and 10 like: 3, 5 or 10 minutes
  ///
  /// In en, this message translates to:
  /// **'{numberOfMinutes} minutes'**
  String minutesBeteenThreeAndTen(int numberOfMinutes);

  /// number of minutes more than 10 like: 11 minutes
  ///
  /// In en, this message translates to:
  /// **'{numberOfMinutes} minutes'**
  String minutesMoreThanTen(int numberOfMinutes);

  /// the hour word
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get hour;

  /// the 2 hours word
  ///
  /// In en, this message translates to:
  /// **'2 hours'**
  String get twoHours;

  /// number of hours between 3 and 10 like: 3, 5 or 10 hours
  ///
  /// In en, this message translates to:
  /// **'{numberOfHours} hours'**
  String hoursBeteenThreeAndTen(int numberOfHours);

  /// number of hours more than 10 like: 11 hours
  ///
  /// In en, this message translates to:
  /// **'{numberOfHours} hours'**
  String hoursMoreThanTen(int numberOfHours);

  /// the day word
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// the 2 days word
  ///
  /// In en, this message translates to:
  /// **'2 days'**
  String get twoDays;

  /// number of days between 3 and 10 like: 3, 5 or 10 days
  ///
  /// In en, this message translates to:
  /// **'{numberOfDays} days'**
  String daysBeteenThreeAndTen(int numberOfDays);

  /// number of days more than 10 like: 11 days
  ///
  /// In en, this message translates to:
  /// **'{numberOfDays} days'**
  String daysMoreThanTen(int numberOfDays);

  /// the week word
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get week;

  /// the 2 weeks word
  ///
  /// In en, this message translates to:
  /// **'2 weeks'**
  String get twoWeeks;

  /// number of weeks between 3 and 10 like: 3, 5 or 10 weeks
  ///
  /// In en, this message translates to:
  /// **'{numberOfWeeks} weeks'**
  String weeksBeteenThreeAndTen(int numberOfWeeks);

  /// number of weeks more than 10 like: 11 weeks
  ///
  /// In en, this message translates to:
  /// **'{numberOfWeeks} weeks'**
  String weeksMoreThanTen(int numberOfWeeks);

  /// the month word
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// the 2 months word
  ///
  /// In en, this message translates to:
  /// **'2 months'**
  String get twoMonths;

  /// number of months between 3 and 10 like: 3, 5 or 10 months
  ///
  /// In en, this message translates to:
  /// **'{numberOfMonths} months'**
  String monthsBeteenThreeAndTen(int numberOfMonths);

  /// number of months more than 10 like: 11 months
  ///
  /// In en, this message translates to:
  /// **'{numberOfMonths} months'**
  String monthsMoreThanTen(int numberOfMonths);

  /// the year word
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get year;

  /// the 2 years word
  ///
  /// In en, this message translates to:
  /// **'2 years'**
  String get twoYears;

  /// number of years between 3 and 10 like: 3, 5 or 10 years
  ///
  /// In en, this message translates to:
  /// **'{numberOfYears} years'**
  String yearsBeteenThreeAndTen(int numberOfYears);

  /// number of years more than 10 like: 11 years
  ///
  /// In en, this message translates to:
  /// **'{numberOfYears} years'**
  String yearsMoreThanTen(int numberOfYears);

  /// the decade word
  ///
  /// In en, this message translates to:
  /// **'decade'**
  String get decade;

  /// the 2 decades word
  ///
  /// In en, this message translates to:
  /// **'2 decades'**
  String get twoDecades;

  /// number of decades between 3 and 10 like: 3, 5 or 10 decades
  ///
  /// In en, this message translates to:
  /// **'{numberOfDecades} decades'**
  String decadesBeteenThreeAndTen(int numberOfDecades);

  /// number of decades more than 10 like: 11 decades
  ///
  /// In en, this message translates to:
  /// **'{numberOfDecades} decades'**
  String decadesMoreThanTen(int numberOfDecades);

  /// the home word
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// the title of forDoctorsScreen
  ///
  /// In en, this message translates to:
  /// **'For Doctors'**
  String get forDoctors;

  /// title of ForPatients screen
  ///
  /// In en, this message translates to:
  /// **'For Patients'**
  String get forPatients;

  /// Open Menu tooltip of mainScreen
  ///
  /// In en, this message translates to:
  /// **'Open Menu'**
  String get openMenu;

  /// the profile button of menue screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// title of settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// the Share The App word
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTheApp;

  /// share text of share the app button in menue screen
  ///
  /// In en, this message translates to:
  /// **'          \"Breast Cancer Awareness App\"\n\nEmpowering individuals to take charge of their breast health.\n\nYou can download this app from Google Play, by following this link: \nhttps://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness'**
  String get shareTheAppText;

  /// the about button of menue screen
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// the log out button of menue screen
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// the Sign In button of menue screen 'guest view'
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Check for updates tooltip of about screen
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get checkForUpdates;

  /// the response if error accured while checkForUpdates
  ///
  /// In en, this message translates to:
  /// **'error happend while checking for updates!!'**
  String get errorHappendWhileCheckingForUpdates;

  /// the No Updates word
  ///
  /// In en, this message translates to:
  /// **'No Updates'**
  String get noUpdates;

  /// the response if no updates after checkForUpdates
  ///
  /// In en, this message translates to:
  /// **'You have the latest version of Breast Cancer Awareness 👍👍'**
  String get youHaveTheLatestVersion;

  /// the Need Update word
  ///
  /// In en, this message translates to:
  /// **'Need Update'**
  String get needUpdate;

  /// the response if you have to force update the app
  ///
  /// In en, this message translates to:
  /// **'This version of Breast Cancer Awareness isn\'t supported anymore, You have to update to the latest version.'**
  String get thisVersionOfTheAppNotSupportedAnymore;

  /// the Update word
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// the response if you have to force update the app after some days
  ///
  /// In en, this message translates to:
  /// **'This version of Breast Cancer Awareness needs to be **updated in {numberOfDays}**.\n\nUpdate to the latest version?'**
  String thisVersionOfTheAppNotSupportedAfterDays(String numberOfDays);

  /// the Later word
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// the update App? word
  ///
  /// In en, this message translates to:
  /// **'Update App?'**
  String get updateApp;

  /// the response if you can choose if you want to update the app
  ///
  /// In en, this message translates to:
  /// **'A new version of Breast Cancer Awareness is available! Version {latestAppVersion} is now available-you have {currentAppVersion}\n\nWould you like to update it now?'**
  String newVersionOfTheAppIsAvailable(
    String latestAppVersion,
    String currentAppVersion,
  );

  /// the reset to default tooltip in `_SETTINGS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Reset to default'**
  String get resetToDefault;

  /// theme text of settings screen
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// System default of theme
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// Light mode of theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark mode of theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// the language word
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// the notifications word
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// tooltip Change to Language of sign in screen
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// tooltip Change to Light Mode of ToggleThemeButton
  ///
  /// In en, this message translates to:
  /// **'Change to Light Mode'**
  String get changeToLightMode;

  /// tooltip Change to Dark Mode of ToggleThemeButton
  ///
  /// In en, this message translates to:
  /// **'Change to Dark Mode'**
  String get changeToDarkMode;

  /// in `_SETTINGS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Speak search result'**
  String get speakSearchResult;

  /// one of the choices of `speak search result`
  ///
  /// In en, this message translates to:
  /// **'Always speak'**
  String get alwaysSpeak;

  /// one of the choices of `speak search result`
  ///
  /// In en, this message translates to:
  /// **'When voice search'**
  String get whenVoiceSearch;

  /// one of the choices of `speak search result`
  ///
  /// In en, this message translates to:
  /// **'Never speak'**
  String get neverSpeak;

  /// tooltip for button to change speech language in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Select a language to use voice search'**
  String get selectALanguageToUseVoiceSearch;

  /// in `_SETTINGS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Voice search language'**
  String get voiceSearchLanguage;

  /// the default word
  ///
  /// In en, this message translates to:
  /// **'default'**
  String get defaultWord;

  /// the All Languages word
  ///
  /// In en, this message translates to:
  /// **'All Languages'**
  String get allLanguages;

  /// title of the about screen
  ///
  /// In en, this message translates to:
  /// **'App Overview'**
  String get appOverview;

  /// the details of the abb Overview in about screen
  ///
  /// In en, this message translates to:
  /// **'**Breast Cancer Awareness app** is a comprehensive tool designed to raise awareness and promote early detection of breast cancer. It addresses four key aspects: providing `information and awareness`, facilitating `self-examination` through a symptom checker, assisting doctors with `deep learning models` for detection, and offering support `resources` and `guidance` for patients.\n* **Purpose:** The app was created with the primary goal of empowering individuals to take charge of their breast health. By amalgamating information, self-examination tools, advanced detection models, and supportive resources, we aim to contribute to the early detection and management of breast cancer.\n* **Target Audience:** Our target audience spans a wide range, including individuals of all genders interested in breast health awareness, those performing self-examinations, medical professionals seeking advanced diagnostic tools, and patients in need of support and guidance.\n\n**Key Features**\n* **Information Hub:** Accessible information on breast cancer, its symptoms, risk factors, and preventive measures.\n* **Symptom Checker:** An interactive self-examination tool guiding users through the detection of potential symptoms.\n* **Deep Learning Models:** Advanced AI models for doctors, aiding in the detection of breast cancer from mammogram and histopathology images.\n* **Patient Support:** Nutrition, diet, and exercise guidance, along with a chatbot providing answers and guidance through text-to-speech and speech-to-text capabilities.\n\n**Data and Research**\n* **The Breast Cancer Awareness app** is built on a foundation of thorough research and collaboration with medical professionals. We\'ve incorporated insights from reputable studies and partnered with experts in the field to develop the deep learning models. The app\'s content is curated based on evidence-based information to ensure accuracy and reliability.\n\n**Contact and App Privacy**'**
  String get appOverviewdetailed;

  /// contact Us through email in about screen
  ///
  /// In en, this message translates to:
  /// **'Contact us through this email:'**
  String get contactUs;

  /// the app word
  ///
  /// In en, this message translates to:
  /// **'App '**
  String get app;

  /// the privacy Policy word
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// the terms of service word
  ///
  /// In en, this message translates to:
  /// **'Terms Of Service'**
  String get termsOfService;

  /// the response if an `API` error
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again later.'**
  String get somethingWentWrongPleaseTryAgainLater;

  /// the response if an `API` error **No data**
  ///
  /// In en, this message translates to:
  /// **'Error happened, There is no data for that Account'**
  String get errorHappendThereIsNoDataForThatAccount;

  /// the response if error not associated with `API` directly
  ///
  /// In en, this message translates to:
  /// **'An unexpected error happened.'**
  String get unexpectedErrorHappened;

  /// the response if an `API` error of `sign in`
  ///
  /// In en, this message translates to:
  /// **'User not found for that email.'**
  String get userNotFoundForThatEmail;

  /// the response if an `API` error
  ///
  /// In en, this message translates to:
  /// **'Email Not Valid.'**
  String get emailNotValid;

  /// the response if an `API` error
  ///
  /// In en, this message translates to:
  /// **'The password is wrong.'**
  String get thePasswordIsWrong;

  /// the response if an `API` error
  ///
  /// In en, this message translates to:
  /// **'The User is not found for that email OR The password is wrong.'**
  String get theUserIsNotFoundForThatEmailOrThePasswordIsWrong;

  /// the response if an `API` error
  ///
  /// In en, this message translates to:
  /// **'The provided password is weak try to put a strong password.'**
  String get theProvidedPasswordIsWeakTryToPutAStrongPassword;

  /// the response if an `API` error `sign up`
  ///
  /// In en, this message translates to:
  /// **'The provided email already exists, sign in instead or provide another email.'**
  String get theProvidedEmailAlreadyExistsSignInInsteadOrProvideAnotherEmail;

  /// the response if an no token error or `not sellecting a social account`
  ///
  /// In en, this message translates to:
  /// **'No {provider} account was selected!!!'**
  String noProviderNameAccountWasSelected(String provider);

  /// the response if an `API` error `trying to sign up with social account already signed`
  ///
  /// In en, this message translates to:
  /// **'An account already exists with the same email address as your {providerName} account.\nSign in using the account that is associated with this email address.'**
  String anAccountAlreadyExistsWithTheSameEmailAddressAsYourProviderAccount(
    String providerName,
  );

  /// the response if an `API` error `trying to reauthenticate with different account`
  ///
  /// In en, this message translates to:
  /// **'You selected a different {providerName} Account.\nselect the {providerName} Account that you logged in with the App. OR re-sign into the app instead.'**
  String youSelectedADifferentProviderAccount(String providerName);

  /// response if error happend while getting user data
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!!'**
  String get somethingWentWrong;

  /// all the available user data in case of 'guest or anonymous' user
  ///
  /// In en, this message translates to:
  /// **'You Are a Guest'**
  String get youAreAGuest;

  /// the Email word
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// the Facebook word
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// the Twitter word
  ///
  /// In en, this message translates to:
  /// **'Twitter'**
  String get twitter;

  /// the X word 'for X company OR Twitter'
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get x;

  /// the Google word
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// tooltip of providerName of profile screen
  ///
  /// In en, this message translates to:
  /// **'Email of Your {providerName} Account'**
  String emailOfYourProviderAccount(String providerName);

  /// the Full Name tooltip
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// in case if user didn't provide a phone number of profile screen
  ///
  /// In en, this message translates to:
  /// **'No phone number provided'**
  String get noPhoneNumberProvided;

  /// the Phone Number word
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// the Doctor word
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// the Patient word
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// the Normal word
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// the User Type tooltip
  ///
  /// In en, this message translates to:
  /// **'User Type'**
  String get userType;

  /// the type of the user on the profile screen, like 'Doctor User'
  ///
  /// In en, this message translates to:
  /// **'{userType} User'**
  String userOf(String userType);

  /// the date when the user joned in profile screen
  ///
  /// In en, this message translates to:
  /// **'Joined {dateOfSignUp}'**
  String joinedIn(String dateOfSignUp);

  /// edit Profile button in profile screen and EditProfileScreen
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Delete Account button in profile screen
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// the title of confirm delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Dangerous area'**
  String get dangerousArea;

  /// the content of confirm delete account dialog
  ///
  /// In en, this message translates to:
  /// **'* Are you sure of **Deleting your account?** All the data and information will be deleted. **That can\'t be undone.**\n* You may be asked to **confirm** your credentials to ensure it is you.'**
  String get areYouSureOfDeletingYourAccount;

  /// the Delete word
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// the contentString of putting password dialog 'to delete Password type account'
  ///
  /// In en, this message translates to:
  /// **'Please enter your password to confirm deleting your account.'**
  String get pleaseEnterYourPasswordToConfirm;

  /// the Password word
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// password formField error if num of char is less than 8
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long.'**
  String get passwordMustBeAtLeast8CharactersLong;

  /// the Save word
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// error if you try to save in EditProfileScreen and firstName or lastName is empty
  ///
  /// In en, this message translates to:
  /// **'Some Fields are Empty.'**
  String get someFieldsAreEmpty;

  /// error if you try to save in EditProfileScreen and phone number is not valid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid Phone Number.'**
  String get pleaseEnterAValidPhoneNumber;

  /// 'Select Image' word basicly tooltip or button
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// 'Change Image' word basicly tooltip or button
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// 'Clear The Image' word basicly tooltip or button
  ///
  /// In en, this message translates to:
  /// **'Clear The Image'**
  String get clearTheImage;

  /// First Name hint text in textField
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Last Name hint text in textField
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// error under textField 'validator' if you did not put the first name
  ///
  /// In en, this message translates to:
  /// **'Please enter the first name.'**
  String get pleaseEnterTheFirstName;

  /// error under textField 'validator' if you did not put the last name
  ///
  /// In en, this message translates to:
  /// **'Please enter the last name.'**
  String get pleaseEnterTheLastName;

  /// the Log in word
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// in sign in screen
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue'**
  String get pleaseSignInToContinue;

  /// if email is not valid from RegExpresion
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get pleaseEnterAValidEmailAddress;

  /// the button in sign in screen in case password forgoten
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// in sign in in screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAnAccount;

  /// the Sign Up word
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// the Or word
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// in sign in in screen
  ///
  /// In en, this message translates to:
  /// **'Sign up later? '**
  String get signUpLater;

  /// button in sign in in screen
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// tooltip for social sign in in `sign in screen`
  ///
  /// In en, this message translates to:
  /// **'Sign in using {provider} Account'**
  String signInUsingProviderAccount(String provider);

  /// in `passwordResetScreen`
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotYourPassword;

  /// in `passwordResetScreen`
  ///
  /// In en, this message translates to:
  /// **'Put your Email to send a link for resetting your password.'**
  String get putYourEmailToSendALinkForResettingYourPassword;

  /// the followUp word
  ///
  /// In en, this message translates to:
  /// **'Follow up'**
  String get followUp;

  /// the finishedResetting word in `passwordResetScreen`
  ///
  /// In en, this message translates to:
  /// **'Finished resetting'**
  String get finishedResetting;

  /// in `passwordResetScreen`
  ///
  /// In en, this message translates to:
  /// **'Send Reset Request'**
  String get sendResetRequest;

  /// instruction in dialog for resetting password
  ///
  /// In en, this message translates to:
  /// **'* Check your **inbox** for an email that has just been sent for your {userEmail}.\n* Follow the **link** and reset your password.\n* When you **finish**, return to the app and sign in with the new password.'**
  String checkYourInboxForAnEmailThatHasJustBeenSent(String userEmail);

  /// the createAnAccount word in `_FIRST_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// the response if name is less than 2 letters in `_FIRST_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid name.'**
  String get pleaseEnterAValidName;

  /// the confirm Password word in `_FIRST_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// in `_FIRST_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Empty Field, Please confirm the password.'**
  String get emptyFieldPleaseConfirmThePassword;

  /// if the first and second passord (confirmPassword) not alike in `_FIRST_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Those passwords didn\'t match. Try again.'**
  String get thosePasswordsDidntMatchTryAgain;

  /// the alreadyHaveAnAccount word in `_FIRST_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Already have an account ? '**
  String get alreadyHaveAnAccount;

  /// the selectUserType word in `_SECOND_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Select User Type'**
  String get selectUserType;

  /// button if error happend in `_SECOND_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Skip For Now'**
  String get skipForNow;

  /// button in `_SECOND_SIGN_UP_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueToMainScreen;

  /// the Hello word
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// the greeting in `_HOME_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'You understand that every day counts when it comes to early breast cancer detection. it\'s great that you take responsibility for your health and check your breasts regularly.'**
  String
  get youUnderstandThatEveryDayCountsWhenItComesToEarlyBreastCancerDetection;

  /// self check button on the home screen
  ///
  /// In en, this message translates to:
  /// **'SELF-CHECK NOW'**
  String get selfCheckNow;

  /// Breast Check History button on the home screen
  ///
  /// In en, this message translates to:
  /// **'MY BREAST-CHECK HISTORY'**
  String get myBreastCheckHistory;

  /// title of awareness in `_HOME_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Awareness\nAnd\nWhy early detection is important'**
  String get breastCancerAwarenessandwhy;

  /// the LEARN MORE word
  ///
  /// In en, this message translates to:
  /// **'LEARN MORE'**
  String get learnMore;

  /// the Description word
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// the response if error happened while trying to save file to local device storage in
  ///
  /// In en, this message translates to:
  /// **'Not able to save files to local device storage.'**
  String get notAbleToSaveFilesToLocalDeviceStorage;

  /// the response if error happened while trying to delete file to local device storage
  ///
  /// In en, this message translates to:
  /// **'Not able to delete files from local device storage.'**
  String get notAbleToDeleteFilesFromLocalDeviceStorage;

  /// tooltip for button to delete all Self check in `_NOTES_HISTORY_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Delete All Self-Checks'**
  String get deleteAllSelfchecks;

  /// the mySelfchecks word in `_NOTES_HISTORY_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'My Self-checks'**
  String get mySelfchecks;

  /// the Warning word
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// the deleteAll word
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// in case of `Directionality.of(context) == TextDirection.ltr`
  ///
  /// In en, this message translates to:
  /// **'from left to right'**
  String get fromLeftToRight;

  /// in case of `Directionality.of(context) == TextDirection.rtl`
  ///
  /// In en, this message translates to:
  /// **'from right to left'**
  String get fromRightToLeft;

  /// the content of dialog when trying to delete all self checks in `_NOTES_HISTORY_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'* Are you sure of **Deleting all your Self-Checks?** All the data and notes information will be deleted.\n* If you want to delete a specific note, **drag** it {textDirection}'**
  String areYouSureOfDeletingAllYourSelfchecks(String textDirection);

  /// the textNote word in `_NOTE_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Text Note'**
  String get textNote;

  /// the voiceNote word in `_NOTE_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Voice Note'**
  String get voiceNote;

  /// the areYouSure word
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// the confirmDeletion word in dialog of deleteing a note in `_NOTES_HISTORY_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion?'**
  String get confirmDeletion;

  /// the noActivityYet word in case of no notes or self checks yet
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get noActivityYet;

  /// the selfcheck word
  ///
  /// In en, this message translates to:
  /// **'Self-Check'**
  String get selfcheck;

  /// instructions fro `_STARTING_SELF_CHECK_WHAT_TO_LOOK_FOR_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'Let yourself be guided by text and graphics Step by Step'**
  String get letYourselfBeGuidedByTextAndGraphicsStepByStep;

  /// button in `_STARTING_SELF_CHECK_WHAT_TO_LOOK_FOR_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'START SELF-CHECK'**
  String get startSelfcheck;

  /// button in `_STARTING_SELF_CHECK_WHAT_TO_LOOK_FOR_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'WHAT SHOULD I LOOK FOR?'**
  String get whatShouldILookFor;

  /// the title of `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'What to look for'**
  String get whatToLookFor;

  /// one of titles in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'Lumps, knots, thickenings'**
  String get lumpsKnotsThickenings;

  /// one of titles in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'Changes in size or shape'**
  String get changesInSizeOrShape;

  /// one of titles in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'Nipple discharge'**
  String get nippleDischarge;

  /// one of titles in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'Skin changes'**
  String get skinChanges;

  /// one of details in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'Lumps, hardened knots or thickenings in the breast tissue can be a sign of breast cancer. They can occur right under the skin, in the middle of the breast or in the deep tissue near the bones.'**
  String get lumpsKnotsThickeningsDetails;

  /// one of details in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'Unusual changes in size, contour or shape should be checked. The same is true for distortions or swellings. Keep in mind that your left and right breast might look different. Know what is normal for you.'**
  String get changesInSizeOrShapeDetails;

  /// one of details in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'The nipple should look normal to you, and should be free from irritation. Check for unusual discharge of fluid or blood'**
  String get nippleDischargeDetails;

  /// one of details in `_what_to_look_for_screen`
  ///
  /// In en, this message translates to:
  /// **'There should be no strange wrinkling or bulging of the skin. Get checked if there is any persistent redness, soreness or rash, especially if only on one side.'**
  String get skinChangesDetails;

  /// pageNaviagtor in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'{numPage} of {numPages}'**
  String pageOf(int numPage, int numPages);

  /// tooltip if the current page is 1 in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'This Is The First Step'**
  String get thisIsTheFirstStep;

  /// tooltip to go to Previous page in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Previous Step'**
  String get previousStep;

  /// tooltip if the current page is last in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'End Self-check'**
  String get endSelfcheck;

  /// tooltip to go to nex page in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// button to open mirror screen **fronCameraScreen** in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'SWITCH TO MIRROR'**
  String get switchToMirror;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Look'**
  String get look;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Feel'**
  String get feel;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Circles'**
  String get circles;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Armpit'**
  String get armpit;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Nipple'**
  String get nipple;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Lie down'**
  String get lieDown;

  /// one of the titles in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Helpful hint: Shower'**
  String get helpfulHintShower;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Start in an upright position, hands on your hips. Look at your breasts with the help of a mirror, your mobile phone, or a friend.'**
  String get startDetails;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Do you see any changes in size, shape or colour? Swelling? Puckering of the skin? Raise your arms and check again.'**
  String get lookDetails;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Use the pads of your fingers and feel your breast. Follow a pattern. Feel for lumps, hardened knots and thickenings.'**
  String get feelDetails;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'keep your fingers together and flat. Move in small circles. Repeat using light, medium and then firm pressure. With firm pressure, you should feel your ribcage.'**
  String get circlesDetails;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Cover all the way up to your armpit. The left hand feels the right side and the right hand feels the left side.'**
  String get armpitDetails;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Squeeze the nipple. Is there any unusual discharge?'**
  String get nippleDetails;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Lie down so the tissue spreads out evenly. Repeat the examination of your breasts.'**
  String get lieDownDetails;

  /// one of the descriptions in `_SELF_CHECK_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'You can do your self-check under the shower. Sometimes it\'s easier when the breast is wet and soapy.'**
  String get helpfulHintShowerDetails;

  /// the title of `_finding_screen`
  ///
  /// In en, this message translates to:
  /// **'Findings'**
  String get findings;

  /// in `_finding_screen`
  ///
  /// In en, this message translates to:
  /// **'Congratulations! It\'s great that you are taking care of your health.'**
  String get congratulationsItsGreatThatYouAreTakingCareOfYourHealth;

  /// button to click if all is well in self-check in `_finding_screen`
  ///
  /// In en, this message translates to:
  /// **'All is well'**
  String get allIsWell;

  /// button to click if Not sure if you noticedSomething in self-check in `_finding_screen`
  ///
  /// In en, this message translates to:
  /// **'Not sure'**
  String get notSure;

  /// button to click if Noticed something in self-check in `_finding_screen`
  ///
  /// In en, this message translates to:
  /// **'Noticed something'**
  String get noticedSomething;

  /// some of text of `_NOTES_AND_REMINDER_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'Your reminder has been set:'**
  String get yourReminderHasBeenSet;

  /// some of text of `_NOTES_AND_REMINDER_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'Do you want to be reminded to check again in {durationInString}?'**
  String doYouWantToBeRemindedToCheckAgainIn(String durationInString);

  /// the message of notification to make self-check
  ///
  /// In en, this message translates to:
  /// **'Your next self-check is due.'**
  String get yourNextSelfcheckIsDue;

  /// the title of `_NOTES_AND_REMINDER_SCREENS` if not all is well
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry'**
  String get dontWorry;

  /// the title of `_NOTES_AND_REMINDER_SCREENS` if all is well
  ///
  /// In en, this message translates to:
  /// **'Next reminder'**
  String get nextReminder;

  /// some of text of `_NOTES_AND_REMINDER_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'If you noticed anything unusual when examining your breasts, stay calm! Check the area again after your next menstruation. If the change persists, you should see a doctor.\n\n'**
  String get ifYouNoticedAnythingUnusualWhenExaminingYourBreasts;

  /// some of text of `_NOTES_AND_REMINDER_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'You will automatically be reminded of your next self-check.\n\nThis is on:'**
  String get youWillAutomaticallyBeReminded;

  /// the Add note word
  ///
  /// In en, this message translates to:
  /// **'Add notes'**
  String get addNotes;

  /// the FINISH word
  ///
  /// In en, this message translates to:
  /// **'FINISH'**
  String get finish;

  /// in textField of adding text note in `_NOTES_AND_REMINDER_SCREENS`
  ///
  /// In en, this message translates to:
  /// **'Enter a text note'**
  String get enterATextNote;

  /// the response if microphone permission not granted from user to record a voice note
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is needed to record a voice note.'**
  String get microphonePermissionIsNeededToRecordAVoiceNote;

  /// the Recording word
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get recording;

  /// instruction for models usage
  ///
  /// In en, this message translates to:
  /// **'Pick a Medical Image of Breast Cancer Mammogram (X-Ray) or Histology of The Patient.'**
  String
  get pickAMedicalImageOfBreastCancerMammogramXrayOrHistologyOfThePatient;

  /// instruction for models usage
  ///
  /// In en, this message translates to:
  /// **'See The Result OR Prediction Using The Deep Learning Models.'**
  String get seeTheResultOrPredictionUsingTheDeepLearningModels;

  /// the Caution word
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get caution;

  /// Caution instruction for using the AI models
  ///
  /// In en, this message translates to:
  /// **'These `AI models` are tools for assisting medical professionals and should only be used by `trained specialists`. It is `not a substitute` for expert medical judgment, diagnosis, or treatment. \n* **Please be aware** that the predictions made by this models are not 100 percent accurate, and they should not be solely relied upon for making medical decisions. Always consult with a qualified healthcare provider or breast cancer specialist for a comprehensive evaluation and diagnosis. \n* **Using this models without expert oversight** may lead to incorrect conclusions and potentially harmful outcomes. Your health and well-being are of utmost importance, and this AI models is meant to complement, not replace, the expertise of medical professionals. \n* **Please exercise caution and discretion** when interpreting the results generated by this AI models and seek the guidance of a qualified healthcare professional for any concerns related to breast cancer or your overall health.'**
  String get thisAiModelsAreToolsForAssistingMedicalProfessionals;

  /// the response if no image provided in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'You didn\'t provide an image!!!'**
  String get youDidntProvideAnImage;

  /// the response in case if guest user in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'You have to Sign In to continue!!'**
  String get youHaveToSignInToContinue;

  /// the Sorry word
  ///
  /// In en, this message translates to:
  /// **'Sorry'**
  String get sorry;

  /// the response in case if guest user in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'This feature only available to Doctors.'**
  String get thisFeatureOnlyAvailableToDoctors;

  /// the tooltip of addButton in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'hide image box above'**
  String get hideImageBoxAbove;

  /// the tooltip of addButton in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'show image box'**
  String get showImageBox;

  /// the button to show result of models in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Show Result'**
  String get showResult;

  /// the title of dialog to choose image type in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Select Medical Image Type'**
  String get selectMedicalImageType;

  /// one of the medical image types that the model can predict
  ///
  /// In en, this message translates to:
  /// **'X-Ray Image'**
  String get xrayImage;

  /// one of the medical image types that the model can predict
  ///
  /// In en, this message translates to:
  /// **'Histology Image'**
  String get histologyImage;

  /// the Select word
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// the openCamera word
  ///
  /// In en, this message translates to:
  /// **'Open Camera'**
  String get openCamera;

  /// the pickAnImage word
  ///
  /// In en, this message translates to:
  /// **'Pick an Image'**
  String get pickAnImage;

  /// in the link textField in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Or Paste a Link here'**
  String get orPasteALinkHere;

  /// the response if no QRCode readed in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'you didn\'t read QR Code'**
  String get youDidntReadQrCode;

  /// the response if error happened when trying to read QRCode in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Error happened while trying to open QR Code Scanner'**
  String get errorHappenedWhileTryingToOpenQrCodeScanner;

  /// the button in `_FOR_DOCTOR_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Get Image Link By Reading QR Code'**
  String get getImageLinkByReadingQrCode;

  /// whene the model is waiting to get response
  ///
  /// In en, this message translates to:
  /// **'it may take a while, the model is getting downloaded or updated.'**
  String get itMayTakeAWhileTheModelIsGettingDownloaded;

  /// the Normal word for `prediction label`
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normalLabel;

  /// the cancer word for `prediction label`
  ///
  /// In en, this message translates to:
  /// **'Cancer'**
  String get cancerLabel;

  /// the above 90 word
  ///
  /// In en, this message translates to:
  /// **'above 90'**
  String get aboveNinety;

  /// the title of `PredictionScreen` to detrmine the type of the mediacl image
  ///
  /// In en, this message translates to:
  /// **'Prediction of {imageType}'**
  String predictionOf(String imageType);

  /// the prediction details of the models
  ///
  /// In en, this message translates to:
  /// **'{prediction} with {confidence}% confidence'**
  String predictionWithConfidence(String prediction, String confidence);

  /// the response if the result of web search filtered
  ///
  /// In en, this message translates to:
  /// **'Sorry, there is no result for your search, the result has been filtered.'**
  String get sorryThereIsNoResultForYourSearch;

  /// the response if the result of AI search filtered
  ///
  /// In en, this message translates to:
  /// **'**Sorry, there is no result for your search**\n\n* The result has been filtered.\n* Or you are searching with a **language** that is not supported yet.'**
  String get sorryThereIsNoResultForYourSearchWithDetails;

  /// one of the titles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'TIPS FOR YOUR VISIT TO THE DOCTOR'**
  String get tipsForYourVisitToTheDoctor;

  /// one of the subtitles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Tips for things to say & do at your doctor\'s appointment.'**
  String get tipsForYourVisitToTheDoctorDetails;

  /// one of the titles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'SEARCH ABOUT BREAST CANCER'**
  String get searchAboutBreastCancer;

  /// one of the subtitles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Search for info OR ask AI for guidance'**
  String get searchAboutBreastCancerDetails;

  /// one of the titles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'CANCER & NUTRITION'**
  String get cancerNutrition;

  /// one of the subtitles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Information and guidelines for maintaining a healthy diet during cancer treatment.'**
  String get cancerNutritionDetais;

  /// one of the titles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'EXERCISE & PHYSICAL ACTIVITY'**
  String get exercisePhysicalActivity;

  /// one of the subtitles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Regular exercise and physical activity are essential.'**
  String get exercisePhysicalActivityDetais;

  /// one of the titles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'OTHER RESOURCES'**
  String get otherResources;

  /// one of the subtitles of `_FOR_PATIENTS_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Take a look at some other helpful resources.'**
  String get otherResourcesDetails;

  /// one of the details of `_TIPS_FOR_YOUR_VISIT_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Tips For Your Doctor\'s Visit'**
  String get tipsForYourDoctorsVisit;

  /// one of the details of `_TIPS_FOR_YOUR_VISIT_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Tips for things to say & do at your doctors appointment.\n\nRemember, we\'re not medical professionals but we are here to support you. Here are some tips for things to say and do at your appointment, but we encourage you to do further research.\n\n'**
  String get tipsForThingsToSayDoAtYourDoctorsAppointment;

  /// one of the details of `_TIPS_FOR_YOUR_VISIT_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'We want to help provide you with tools to be your own health advocate.\n\n'**
  String get weWantToHelpProvideYouWithToolsToBeYourOwnHealthAdvocatenn;

  /// one of the details of `_TIPS_FOR_YOUR_VISIT_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Have your app handy to reference your notes at the doctor\'s office. It\'s always good to have information written down, that way you don\'t forget anything important.\n'**
  String get haveYourAppHandyToReferenceYourNotes;

  /// one of the details of `_TIPS_FOR_YOUR_VISIT_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Bring someone with you to take notes or ask your doctor if you can record your discussion so you have all the information. Having someone there can help ensure all your questions are answered, or help advocate for you, if necessary.\n'**
  String get bringSomeoneWithYouToTakeNotesOrAskYourDoctor;

  /// one of the details of `_TIPS_FOR_YOUR_VISIT_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Ask for pamphlets and for their notes to be printed out or emailed to you, if this is not done automatically. Get as much information as you can.\n'**
  String get askForPamphletsAndForTheirNotesToBePrintedOut;

  /// one of the details of `_TIPS_FOR_YOUR_VISIT_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Be empowered to get a second opinion. There are lots of reasons this is a good idea. You need to be comfortable with the person you\'re working with, their diagnosis, and treatment - if there is something to be treated. Your doctor may even be able to refer you to someone else for a second opinion.\n'**
  String get beEmpoweredToGetASecondOpinion;

  /// the title of show Tips dialog
  ///
  /// In en, this message translates to:
  /// **'Tips for translation'**
  String get tipsForTranslation;

  /// the tooltip of show Tips dialog
  ///
  /// In en, this message translates to:
  /// **'Show Tips'**
  String get showTips;

  /// above the GIF of show Tips dialog
  ///
  /// In en, this message translates to:
  /// **'GIF to explain the above'**
  String get gifToExplainTheAbove;

  /// the reasons if no GIF of show Tips dialog
  ///
  /// In en, this message translates to:
  /// **'error happened, couldn\'t load the GIF'**
  String get errorHappenedCouldntLoadTheGif;

  /// the content of show Tips dialog
  ///
  /// In en, this message translates to:
  /// **'* **Access Chrome Menu:** In the top-right (or left) corner, you\'ll find three dots (Menu). Tap on them to open the menu.\n* **Select \"Translate\":** Look for the \"Translate\" option in the menu. Tap on it.\n* **Enable Translation:** Toggle the switch to enable translation for the website. Chrome will automatically detect the language of the web page and ask if you want to translate it.\n* **Confirm Translation:** A pop-up will appear asking if you want to translate the page. Tap on \"Translate\" to confirm.'**
  String get accessChromeMenuInstructions;

  /// the subtitle of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Take a look at some other helpful resources\n'**
  String get takeALookAtSomeOtherHelpfulResources;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Support: '**
  String get support;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Young Survival Coalition\n'**
  String get youngSurvivalCoalition;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Treatment: '**
  String get treatment;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Treatment\n'**
  String get breastCancerTreatment;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Children Treatment: '**
  String get childrenTreatment;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Childhood Breast Cancer Treatment\n'**
  String get childhoodBreastCancerTreatment;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'During Pregnancy: '**
  String get duringPregnancy;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Treatment During Pregnancy\n'**
  String get breastCancerTreatmentDuringPregnancy;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'For Males: '**
  String get forMales;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Male Breast Cancer Treatment\n'**
  String get maleBreastCancerTreatment;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Screening: '**
  String get screening;

  /// one of the resources of `_OTHER_RESOURCES_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Screening\n'**
  String get breastCancerScreening;

  /// one of search types in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Ask AI'**
  String get askAi;

  /// one of search types in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Google Search'**
  String get googleSearch;

  /// one of search types in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Google Scholar'**
  String get googleScholar;

  /// one of search types in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Wikipedia Search'**
  String get wikipediaSearch;

  /// the Search word
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// warning dialog in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'This app provides information and assistance related to `medical` topics using `artificial intelligence` and `online resources`. However, it is not a substitute for professional medical advice, diagnosis, or treatment. Please read and consider the following:\n\n* **Consult a Healthcare Professional:** If you have a medical condition, symptoms, or concerns about your health, consult a qualified healthcare provider. This app does not replace the expertise of medical professionals.\n* **Use as a Supplement:** Use this app as a supplemental tool to gather general information about medical topics. It can provide insights and suggestions but should not be your sole source of healthcare guidance.\n* **Not for Emergencies:** In case of a medical emergency, call your local emergency number or seek immediate medical attention. This app is not equipped to handle urgent situations.\n* **Verify Information:** Always verify the information you receive in this app with trusted medical sources or professionals. Medical knowledge evolves, and information provided here may not always reflect the latest guidelines.\n* **User Responsibility:** Your health is your responsibility. Do not make medical decisions solely based on information obtained from this app.'**
  String get thisAppProvidesInformationAndAssistanceRelatedToMedicalTopics;

  /// tooltip of button to select search type in ``_SEARCH_SCREEN
  ///
  /// In en, this message translates to:
  /// **'Select search type'**
  String get selectSearchType;

  /// tooltip of button to searchwith your voice in ``_SEARCH_SCREEN
  ///
  /// In en, this message translates to:
  /// **'Search with your voice'**
  String get searchWithYourVoice;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Symptoms'**
  String get breastCancerSymptoms;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Stages'**
  String get breastCancerStages;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Treatment Options'**
  String get breastCancerTreatmentOptions;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Support Groups'**
  String get breastCancerSupportGroups;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Survivor Stories'**
  String get breastCancerSurvivorStories;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Research'**
  String get breastCancerResearch;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Awareness'**
  String get breastCancerAwareness;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Organizations'**
  String get breastCancerOrganizations;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Diet and Nutrition'**
  String get breastCancerDietAndNutrition;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Exercise and Fitness'**
  String get breastCancerExerciseAndFitness;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Reconstruction'**
  String get breastReconstruction;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Side Effects'**
  String get breastCancerSideEffects;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Medications'**
  String get breastCancerMedications;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Financial Support'**
  String get breastCancerFinancialSupport;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Mental Health'**
  String get breastCancerMentalHealth;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Screening Guidelines'**
  String get breastCancerScreeningGuidelines;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer in Men'**
  String get breastCancerInMen;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Risk Factors'**
  String get breastCancerRiskFactors;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Family History'**
  String get breastCancerFamilyHistory;

  /// one of search keywords in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Breast Cancer Prevention'**
  String get breastCancerPrevention;

  /// if error happend when trying to web search in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'**Your search did not match any results**\n\n* Make sure all words are spelled correctly or Try different keywords.\n* Or you are searching with a **language** that is not supported yet.'**
  String get yourSearchDidNotMatchAnyResultsWithDetails;

  /// the Articles word in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// one of speech to text state in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is needed to Search with your voice.'**
  String get microphonePermissionIsNeededToSearchWithYourVoice;

  /// one of speech to text state in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Microphone off. Try again.'**
  String get microphoneOffTryAgain;

  /// one of speech to text state in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Didn\'t hear that. Try again.'**
  String get didntHearThatTryAgain;

  /// one of speech to text state in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listening;

  /// one of speech to text state in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Tap the microphone to try again'**
  String get tapTheMicrophoneToTryAgain;

  /// one of speech to text state in `_SEARCH_SCREEN`
  ///
  /// In en, this message translates to:
  /// **'Speech not available'**
  String get speechNotAvailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
