


import 'app_localizations.dart';

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appLocale => 'pl';

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
  String get petrolMapWarningNoInternet => 'Brak połączenia z internetem. Dane nie mogą zostać pobrane.';

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
  String get loginPasswordResetMessage => 'Nie pamiętasz hasła?';

  @override
  String get loginPasswordResetButton => 'Zresetuj hasło';

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
  String get resetTitle => 'Zresetuj hasło.';

  @override
  String get resetEmailHint => 'Email';

  @override
  String get resetEmailValidatorMessage => 'Podaj poprawny adres Email';

  @override
  String get resetCorrectPopupTitle => 'Powiadomienie';

  @override
  String get resetCorrectPopupMessage => 'Na twoją skrzynkę mailową został wysłany link do zmiany hasła.';

  @override
  String get resetCorrectPopupClose => 'Zamknij';

  @override
  String get resetErrorPopupTitle => 'Uwaga';

  @override
  String get resetErrorPopupMessage => 'Wystąpił błąd. Sprawdź czy podałeś poprawny adres email.';

  @override
  String get resetErrorPopupClose => 'Zamknij';

  @override
  String get resetApplyButton => 'Resetuj';

  @override
  String get navbar1Item => 'Średnie ceny';

  @override
  String get navbar2Item => 'Stacje';

  @override
  String get navbar3Item => 'Kalkulator';

  @override
  String get drawerTitle => 'Dodatkowe funkcje';

  @override
  String get drawerNotifications => 'Przypomnienia';

  @override
  String get drawerCharts => 'Wykresy';

  @override
  String get drawerSettings => 'Ustawienia';

  @override
  String get drawerAbout => 'O aplikacji';

  @override
  String get drawerLogout => 'Wyloguj';

  @override
  String get drawerPricesAbroad => 'Ceny paliw za granicą';

  @override
  String get aboutTitle => 'O aplikacji';

  @override
  String get aboutVersion => 'Wersja';

  @override
  String get aboutAuthor => 'Autor';

  @override
  String get notificationsTitle => 'Przypomnienia';

  @override
  String get notificationsHint => 'Ustaw przypomnienia dla zdarzeń takich jak ubezpieczenie, czy przegląd okresowy, a otrzymasz powiadomienie 5 dni przed wyznaczoną datą.';

  @override
  String get notificationsHeader => 'Przytrzymaj po więcej informacji';

  @override
  String get notification1Name => 'Koniec ubezpieczenia';

  @override
  String get notification2Name => 'Przegląd okresowy';

  @override
  String get notificationsApplyButton => 'Ustaw Porzypomnienie';

  @override
  String get notification1Title => 'Ubezpieczenie';

  @override
  String get notification1Message => 'Za 5 dni kończy się ubezpieczenie twojego samochodu.';

  @override
  String get notification2Title => 'Przegląd';

  @override
  String get notification2Message => 'Za 5 dni kończy sie data ważności okresowego przęglądu twojego samochodu.';

  @override
  String get dateSelectTitle => 'Wybierz datę';

  @override
  String get notificationDeleteTitle1 => 'Powiadomienie o nazwie \'';

  @override
  String get notificationDeleteTitle2 => '\' zostało usunięte.';

  @override
  String get notificationAddTitle1 => 'Powiadomienie o nazwie \'';

  @override
  String get notificationAddTitle2 => '\' zostało dodane.';

  @override
  String get notificationAlreadySetMessage => 'To powiadomienie jest już ustawione. Jeżeli chcesz zmienić datę, najpierw usuń stare powiadomienie.';

  @override
  String get chartsNavbarTitle => 'Historia cen';

  @override
  String get charts95Title => 'Cena benzyny w ostatnich 3 miesiącach';

  @override
  String get chartsONTitle => 'Cena oleju napędowego w ostatnich 3 miesiącach';

  @override
  String get chartsLPGTitle => 'Cena gazu w ostatnich 3 miesiącach';

  @override
  String get chartsYLabel => 'Cena (zł/l)';

  @override
  String get chartsXLabel => 'Data';

  @override
  String get pricesAbroadTitle => 'Ceny paliw za granicą';

  @override
  String get pricesAbroadTableTitle => 'Kraj';
}
