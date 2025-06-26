// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Travel App';

  @override
  String get welcomeMessage => 'Welcome to Lince Travel App!';

  @override
  String get homePageTitle => 'Home';

  @override
  String get noTravelsMessage => 'No trips registered yet.';
}
