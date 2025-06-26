// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'App de Viagens';

  @override
  String get welcomeMessage => 'Bem-vindo!';

  @override
  String get homePageTitle => 'Início';

  @override
  String get noTravelsMessage => 'Nenhuma viagem cadastrada ainda.';
}
