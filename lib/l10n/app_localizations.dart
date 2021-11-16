
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

  /// No description provided for @appLocale.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get appLocale;

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

  /// No description provided for @petrolMapTooFastUpdateWarning.
  ///
  /// In en, this message translates to:
  /// **'You are trying to update prices too often. Please try again in a few minutes.'**
  String get petrolMapTooFastUpdateWarning;

  /// No description provided for @petrolMapWarningClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get petrolMapWarningClose;

  /// No description provided for @petrolMapSaveSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get petrolMapSaveSuccessTitle;

  /// No description provided for @petrolMapSaveSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Prices have been updated.'**
  String get petrolMapSaveSuccessMessage;

  /// No description provided for @petrolMapSaveSuccessClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get petrolMapSaveSuccessClose;

  /// No description provided for @petrolMapDataLoadIndicator.
  ///
  /// In en, this message translates to:
  /// **'Finding nearby petrol stations...'**
  String get petrolMapDataLoadIndicator;

  /// No description provided for @petrolMapWarningNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Data could not be downloaded.'**
  String get petrolMapWarningNoInternet;

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

  /// No description provided for @loginPasswordResetMessage.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get loginPasswordResetMessage;

  /// No description provided for @loginPasswordResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get loginPasswordResetButton;

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

  /// No description provided for @resetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password.'**
  String get resetTitle;

  /// No description provided for @resetEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get resetEmailHint;

  /// No description provided for @resetEmailValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter valid Email address'**
  String get resetEmailValidatorMessage;

  /// No description provided for @resetCorrectPopupTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get resetCorrectPopupTitle;

  /// No description provided for @resetCorrectPopupMessage.
  ///
  /// In en, this message translates to:
  /// **'A link to change your password has been sent to your email.'**
  String get resetCorrectPopupMessage;

  /// No description provided for @resetCorrectPopupClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get resetCorrectPopupClose;

  /// No description provided for @resetErrorPopupTitle.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get resetErrorPopupTitle;

  /// No description provided for @resetErrorPopupMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occured. Check that you have provided correct email address.'**
  String get resetErrorPopupMessage;

  /// No description provided for @resetErrorPopupClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get resetErrorPopupClose;

  /// No description provided for @resetApplyButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetApplyButton;

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

  /// No description provided for @drawerTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional functions'**
  String get drawerTitle;

  /// No description provided for @drawerNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get drawerNotifications;

  /// No description provided for @drawerCharts.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get drawerCharts;

  /// No description provided for @drawerSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettings;

  /// No description provided for @drawerAbout.
  ///
  /// In en, this message translates to:
  /// **'About app'**
  String get drawerAbout;

  /// No description provided for @drawerLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get drawerLogout;

  /// No description provided for @drawerPricesAbroad.
  ///
  /// In en, this message translates to:
  /// **'Petrol prices abroad'**
  String get drawerPricesAbroad;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About app'**
  String get aboutTitle;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @aboutAuthor.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get aboutAuthor;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get notificationsTitle;

  /// No description provided for @notificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Set reminders for events such as insurance or periodic technical inspection and you will receive a notification 5 days vefore the shceduled date.'**
  String get notificationsHint;

  /// No description provided for @notificationsHeader.
  ///
  /// In en, this message translates to:
  /// **'Hold for more information.'**
  String get notificationsHeader;

  /// No description provided for @notification1Name.
  ///
  /// In en, this message translates to:
  /// **'End of insurance'**
  String get notification1Name;

  /// No description provided for @notification2Name.
  ///
  /// In en, this message translates to:
  /// **'Technical inspection'**
  String get notification2Name;

  /// No description provided for @notificationsApplyButton.
  ///
  /// In en, this message translates to:
  /// **'Set reminder'**
  String get notificationsApplyButton;

  /// No description provided for @notification1Title.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get notification1Title;

  /// No description provided for @notification1Message.
  ///
  /// In en, this message translates to:
  /// **'Insurance for your car ends in 5 days.'**
  String get notification1Message;

  /// No description provided for @notification2Title.
  ///
  /// In en, this message translates to:
  /// **'Technical inspection'**
  String get notification2Title;

  /// No description provided for @notification2Message.
  ///
  /// In en, this message translates to:
  /// **'Technical inspection for your car will expire in 5 days.'**
  String get notification2Message;

  /// No description provided for @dateSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get dateSelectTitle;

  /// No description provided for @notificationDeleteTitle1.
  ///
  /// In en, this message translates to:
  /// **'Notification with name \''**
  String get notificationDeleteTitle1;

  /// No description provided for @notificationDeleteTitle2.
  ///
  /// In en, this message translates to:
  /// **'\' was deleted.'**
  String get notificationDeleteTitle2;

  /// No description provided for @notificationAddTitle1.
  ///
  /// In en, this message translates to:
  /// **'Notification with name \''**
  String get notificationAddTitle1;

  /// No description provided for @notificationAddTitle2.
  ///
  /// In en, this message translates to:
  /// **'\' was added.'**
  String get notificationAddTitle2;

  /// No description provided for @notificationAlreadySetMessage.
  ///
  /// In en, this message translates to:
  /// **'This notification was already set. If you want to change date, first delete old notification.'**
  String get notificationAlreadySetMessage;

  /// No description provided for @chartsNavbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Price history'**
  String get chartsNavbarTitle;

  /// No description provided for @charts95Title.
  ///
  /// In en, this message translates to:
  /// **'Gasoline price in last 3 months'**
  String get charts95Title;

  /// No description provided for @chartsONTitle.
  ///
  /// In en, this message translates to:
  /// **'Diesel price in last 3 months'**
  String get chartsONTitle;

  /// No description provided for @chartsLPGTitle.
  ///
  /// In en, this message translates to:
  /// **'Gas price in last 3 months'**
  String get chartsLPGTitle;

  /// No description provided for @chartsYLabel.
  ///
  /// In en, this message translates to:
  /// **'Price (zł/l)'**
  String get chartsYLabel;

  /// No description provided for @chartsXLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get chartsXLabel;

  /// No description provided for @pricesAbroadTitle.
  ///
  /// In en, this message translates to:
  /// **'Petrol prices abroad'**
  String get pricesAbroadTitle;

  /// No description provided for @pricesAbroadTableTitle.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get pricesAbroadTableTitle;

  /// No description provided for @settingsNavbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsNavbarTitle;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get settingsDarkMode;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


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
