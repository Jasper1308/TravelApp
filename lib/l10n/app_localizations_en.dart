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
  String get welcomeMessage => 'Welcome!';

  @override
  String get homePageTitle => 'Home';

  @override
  String get noTravelsMessage => 'No trips registered yet.';

  @override
  String get car => 'Car';

  @override
  String get motorcycle => 'Motorcycle';

  @override
  String get bus => 'Bus';

  @override
  String get plane => 'Plane';

  @override
  String get cruise => 'Cruise';

  @override
  String get culture => 'Culture';

  @override
  String get culinary => 'Culinary';

  @override
  String get historic => 'Historic';

  @override
  String get localEstablishments => 'Local Establishments';

  @override
  String get nature => 'Nature';

  @override
  String get dateFormat => 'MM/dd/yyyy';
}
