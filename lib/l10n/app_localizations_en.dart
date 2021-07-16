


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get avgPricesTitle => 'Avarage fuel prices';

  @override
  String get avgPricesTableTitle => 'Voivodeship';

  @override
  String get petrolMapTitle => 'Nearest stations';

  @override
  String get petrolMapLastUpdateNever => 'Last update: Never';

  @override
  String get petrolMapLastUpdate => 'Last update: ';

  @override
  String get petrolMapSave => 'Save';

  @override
  String get petrolMapWarningTitle => 'Warning';

  @override
  String get petrolMapWarningMessage => 'Invalid price range. Please provide real data.';

  @override
  String get petrolMapWarningClose => 'Close';

  @override
  String get calculatorTitle => 'Trip calculator';

  @override
  String get calculatorInput1Title => 'Distance';

  @override
  String get calculatorInput1Hint => '(km)';

  @override
  String get calculatorInput2Title => 'Price';

  @override
  String get calculatorInput2Hint => '(zł/l)';

  @override
  String get calculatorInput3Title => 'Avg consumption';

  @override
  String get calculatorInput3Hint => '(l/100km)';

  @override
  String get calculatorResult1Title => 'Total cost of the trip';

  @override
  String get calculatorResult2Title => 'Cost per 100km';

  @override
  String get calculatorApplyButtonTitle => 'Calculate';

  @override
  String get calculatorValidatorMessage => 'Enter valid value';

  @override
  String get loginEmailValidatorMessage => 'Enter Email address';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginPasswordValidatorMessage => 'Enter at least 6 signs';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginButtonApply => 'Login';

  @override
  String get loginNoAccountMessage => 'Don\'t have an account?';

  @override
  String get loginNoAccountButton => 'Create here';

  @override
  String get registerTitle => 'Create an account to continue';

  @override
  String get registerEmailValidatorMessage => 'Enter valid Email address';

  @override
  String get registerEmailHint => 'Email';

  @override
  String get registerPasswordValidatorMessage => 'Enter at least 6 signs';

  @override
  String get registerPasswordHint => 'Password';

  @override
  String get registerButtonApply => 'Create account';

  @override
  String get registerAlreadyMessage => 'Already registered?';

  @override
  String get registerAlreadyButton => 'Login here';

  @override
  String get navbar1Item => 'Avg prices';

  @override
  String get navbar2Item => 'Stations';

  @override
  String get navbar3Item => 'Calculator';

  @override
  String get drawerTitle => 'Additional functions';

  @override
  String get drawerSettings => 'Settings';

  @override
  String get drawerAbout => 'About app';

  @override
  String get drawerLogout => 'Logout';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutAuthor => 'Author';
}
