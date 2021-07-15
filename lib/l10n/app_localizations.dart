
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
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
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @avgPricesTitle.
  ///
  /// In en, this message translates to:
  /// **'Avarage fuel prices'**
  String get avgPricesTitle;

  /// No description provided for @avgPricesTableTitle.
  ///
  /// In en, this message translates to:
  /// **'Voivodeship'**
  String get avgPricesTableTitle;

  /// No description provided for @petrolMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Nearest stations'**
  String get petrolMapTitle;

  /// No description provided for @petrolMapLastUpdateNever.
  ///
  /// In en, this message translates to:
  /// **'Last update: Never'**
  String get petrolMapLastUpdateNever;

  /// No description provided for @petrolMapLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update: '**
  String get petrolMapLastUpdate;

  /// No description provided for @petrolMapSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get petrolMapSave;

  /// No description provided for @petrolMapWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get petrolMapWarningTitle;

  /// No description provided for @petrolMapWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid price range. Please provide real data.'**
  String get petrolMapWarningMessage;

  /// No description provided for @petrolMapWarningClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get petrolMapWarningClose;

  /// No description provided for @calculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip calculator'**
  String get calculatorTitle;

  /// No description provided for @calculatorInput1Title.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get calculatorInput1Title;

  /// No description provided for @calculatorInput1Hint.
  ///
  /// In en, this message translates to:
  /// **'(km)'**
  String get calculatorInput1Hint;

  /// No description provided for @calculatorInput2Title.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get calculatorInput2Title;

  /// No description provided for @calculatorInput2Hint.
  ///
  /// In en, this message translates to:
  /// **'(zł/l)'**
  String get calculatorInput2Hint;

  /// No description provided for @calculatorInput3Title.
  ///
  /// In en, this message translates to:
  /// **'Avg consumption'**
  String get calculatorInput3Title;

  /// No description provided for @calculatorInput3Hint.
  ///
  /// In en, this message translates to:
  /// **'(l/100km)'**
  String get calculatorInput3Hint;

  /// No description provided for @calculatorResult1Title.
  ///
  /// In en, this message translates to:
  /// **'Total cost of the trip'**
  String get calculatorResult1Title;

  /// No description provided for @calculatorResult2Title.
  ///
  /// In en, this message translates to:
  /// **'Cost per 100km'**
  String get calculatorResult2Title;

  /// No description provided for @calculatorApplyButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculatorApplyButtonTitle;

  /// No description provided for @calculatorValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter valid value'**
  String get calculatorValidatorMessage;

  /// No description provided for @loginEmailValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Email address'**
  String get loginEmailValidatorMessage;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 6 signs'**
  String get loginPasswordValidatorMessage;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordHint;

  /// No description provided for @loginButtonApply.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButtonApply;

  /// No description provided for @loginNoAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccountMessage;

  /// No description provided for @loginNoAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create here'**
  String get loginNoAccountButton;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to continue'**
  String get registerTitle;

  /// No description provided for @registerEmailValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter valid Email address'**
  String get registerEmailValidatorMessage;

  /// No description provided for @registerEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailHint;

  /// No description provided for @registerPasswordValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 6 signs'**
  String get registerPasswordValidatorMessage;

  /// No description provided for @registerPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerPasswordHint;

  /// No description provided for @registerButtonApply.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerButtonApply;

  /// No description provided for @registerAlreadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Already registered?'**
  String get registerAlreadyMessage;

  /// No description provided for @registerAlreadyButton.
  ///
  /// In en, this message translates to:
  /// **'Login here'**
  String get registerAlreadyButton;

  /// No description provided for @navbar1Item.
  ///
  /// In en, this message translates to:
  /// **'Avg prices'**
  String get navbar1Item;

  /// No description provided for @navbar2Item.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get navbar2Item;

  /// No description provided for @navbar3Item.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get navbar3Item;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  


// Lookup logic when only language code is specified.
switch (locale.languageCode) {
  case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
}


  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
