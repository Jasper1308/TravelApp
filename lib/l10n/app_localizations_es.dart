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
  String get noTravelsMessage => 'Aún no hay viajes registrados.';

  @override
  String get car => 'Coche';

  @override
  String get motorcycle => 'Moto';

  @override
  String get bus => 'Autobús';

  @override
  String get plane => 'Avión';

  @override
  String get cruise => 'Crucero';

  @override
  String get train => 'Tren';

  @override
  String get culture => 'Cultura';

  @override
  String get culinary => 'Culinario';

  @override
  String get historic => 'Histórico';

  @override
  String get localEstablishments => 'Establecimientos Locales';

  @override
  String get nature => 'Naturaleza';

  @override
  String get dateFormat => 'dd/MM/yyyy';
}
