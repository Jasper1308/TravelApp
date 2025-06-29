// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación de Viajes';

  @override
  String get welcomeMessage => '¡Bienvenido!';

  @override
  String get homePageTitle => 'Inicio';

  @override
  String get noTravelsMessage => 'Ningún viaje registrado aún.';
}
