// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Aplicativo de Viagem';

  @override
  String get welcomeMessage => 'Bem-vindo!';

  @override
  String get homePageTitle => 'Início';

  @override
  String get noTravelsMessage => 'Nenhuma viagem registrada ainda.';

  @override
  String get car => 'Carro';

  @override
  String get motorcycle => 'Moto';

  @override
  String get bus => 'Ônibus';

  @override
  String get plane => 'Avião';

  @override
  String get cruise => 'Cruzeiro';

  @override
  String get culture => 'Cultura';

  @override
  String get culinary => 'Culinária';

  @override
  String get historic => 'Histórico';

  @override
  String get localEstablishments => 'Estabelecimentos Locais';

  @override
  String get nature => 'Natureza';

  @override
  String get dateFormat => 'dd/MM/yyyy';
}
