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
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get arrival => 'Chegada';

  @override
  String get departure => 'Saída';

  @override
  String get durationInDays => 'Duração (em dias)';

  @override
  String get description => 'Descrição';

  @override
  String get add => 'Adicionar';

  @override
  String get myTravels => 'Minhas Viagens';

  @override
  String get noTravels => 'Nenhuma viagem';

  @override
  String get defineTripPeriod =>
      'Defina o período da viagem para adicionar paradas.';

  @override
  String get day => 'Dia';

  @override
  String numberOfDays(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String get registerStop => 'Cadastrar parada';

  @override
  String get preferences => 'Preferências';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Idioma';

  @override
  String get thankYouMessage => 'Obrigado por utilizar';

  @override
  String get map => 'Mapa';

  @override
  String get transportMethod => 'Meio de Transporte';

  @override
  String get finalQuote =>
      'UMA VIAGEM NÃO SE MEDE EM MILHAS, MAS EM MOMENTOS.\nCADA PÁGINA DESTE LIVRETO GUARDA MAIS DO QUE PAISAGENS: SÃO SORRISOS ESPONTÂNEOS, DESCOBERTAS INESPERADAS, CONVERSAS QUE FICARAM NA ALMA E SILÊNCIOS QUE FALARAM MAIS QUE PALAVRAS.';

  @override
  String get loadingPdf => 'Gerando PDF...';
}
