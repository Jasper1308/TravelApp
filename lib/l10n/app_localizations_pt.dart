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
  String get train => 'Trêm';

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

  @override
  String get tapForDetails => 'Toque para detalhes';

  @override
  String get tripName => 'Nome da viagem';

  @override
  String get transport => 'Transporte';

  @override
  String get start => 'Início';

  @override
  String get end => 'Término';

  @override
  String get participants => 'Participantes';

  @override
  String get addParticipant => 'Adicionar participante';

  @override
  String get registerParticipant => 'Cadastrar participante';

  @override
  String get selectParticipant => 'Selecionar participante';

  @override
  String get birthdate => 'Nascimento';

  @override
  String get register => 'Cadastrar';

  @override
  String get requiredName => 'Informe o nome';

  @override
  String get fillAllFields => 'Preencha todos campos';

  @override
  String get select => 'Selecionar';

  @override
  String get saveTrip => 'Salvar viagem';

  @override
  String tripCreated(Object id) {
    return 'Viagem criada (# $id)';
  }

  @override
  String get registerTrip => 'Cadastrar Viagem';

  @override
  String get name => 'Nome';

  @override
  String get travelDetails => 'Detalhes da Viagem';

  @override
  String get loading => 'Carregando...';

  @override
  String get errorLoadingDetails => 'Erro ao carregar detalhes da viagem';

  @override
  String get tripStops => 'Paradas da Viagem';

  @override
  String get myStops => 'Minhas Paradas';

  @override
  String get noStopsRegistered => 'Nenhuma parada registrada nesta viagem.';

  @override
  String get stop => 'Parada';

  @override
  String get noParticipantsRegistered => 'Nenhum participante registrado.';

  @override
  String get generatePdf => 'Gerar PDF';

  @override
  String get experiences => 'Experiências';

  @override
  String get registerExperience => 'Registrar Experiência';

  @override
  String get comment => 'Comentário';

  @override
  String get photo => 'Foto';

  @override
  String get save => 'Salvar';

  @override
  String get noComment => 'Sem comentário';

  @override
  String createdAt(Object createdAt) {
    return 'Criado em: $createdAt';
  }

  @override
  String get loadingPdf => 'Gerando PDF...';
}
