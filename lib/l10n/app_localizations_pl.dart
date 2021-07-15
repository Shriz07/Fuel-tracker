


import 'app_localizations.dart';

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get avgPricesTitle => 'Średnie ceny paliw';

  @override
  String get avgPricesTableTitle => 'Województwo';

  @override
  String get petrolMapTitle => 'Najbliższe stacje';

  @override
  String get petrolMapLastUpdateNever => 'Ostatnia aktualizacja: Nigdy';

  @override
  String get petrolMapLastUpdate => 'Ostatnia aktualizacja: ';

  @override
  String get petrolMapSave => 'Zapisz';

  @override
  String get petrolMapWarningTitle => 'Ostrzeżenie';

  @override
  String get petrolMapWarningMessage => 'Niepoprawny zakres ceny. Ceny powinny być w realnym zakresie';

  @override
  String get petrolMapWarningClose => 'Zamknij';

  @override
  String get calculatorTitle => 'Kalkulator kosztów';

  @override
  String get calculatorInput1Title => 'Odległość';

  @override
  String get calculatorInput1Hint => '(km)';

  @override
  String get calculatorInput2Title => 'Cena';

  @override
  String get calculatorInput2Hint => '(zł/l)';

  @override
  String get calculatorInput3Title => 'Średnie spalanie';

  @override
  String get calculatorInput3Hint => '(l/100km)';

  @override
  String get calculatorResult1Title => 'Całkowity koszt przejazdu';

  @override
  String get calculatorResult2Title => 'Koszt przejazdu 100km';

  @override
  String get calculatorApplyButtonTitle => 'Oblicz koszt';

  @override
  String get calculatorValidatorMessage => 'Podaj poprawną wartość';

  @override
  String get loginEmailValidatorMessage => 'Podaj adres Email';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginPasswordValidatorMessage => 'Podaj przynajmniej 6 znaków';

  @override
  String get loginPasswordHint => 'Hasło';

  @override
  String get loginButtonApply => 'Zaloguj';

  @override
  String get loginNoAccountMessage => 'Nie posiadasz konta?';

  @override
  String get loginNoAccountButton => 'Stwórz konto';

  @override
  String get registerTitle => 'Stwórz konto aby kontynuować';

  @override
  String get registerEmailValidatorMessage => 'Podaj poprawny adres Email';

  @override
  String get registerEmailHint => 'Email';

  @override
  String get registerPasswordValidatorMessage => 'Podaj przynajmniej 6 znaków';

  @override
  String get registerPasswordHint => 'Hasło';

  @override
  String get registerButtonApply => 'Stwórz konto';

  @override
  String get registerAlreadyMessage => 'Posiadasz już konto?';

  @override
  String get registerAlreadyButton => 'Zaloguj';

  @override
  String get navbar1Item => 'Średnie ceny';

  @override
  String get navbar2Item => 'Stacje';

  @override
  String get navbar3Item => 'Kalkulator';
}
