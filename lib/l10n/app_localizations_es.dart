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

  @override
  String get tapForDetails => 'Toca para ver detalles';

  @override
  String get tripName => 'Nombre del viaje';

  @override
  String get transport => 'Transporte';

  @override
  String get start => 'Inicio';

  @override
  String get end => 'Fin';

  @override
  String get participants => 'Participantes';

  @override
  String get addParticipant => 'Agregar participante';

  @override
  String get registerParticipant => 'Registrar participante';

  @override
  String get selectParticipant => 'Seleccionar participante';

  @override
  String get birthdate => 'Fecha de nacimiento';

  @override
  String get register => 'Registrar';

  @override
  String get requiredName => 'Nombre obligatorio';

  @override
  String get fillAllFields => 'Complete todos los campos';

  @override
  String get select => 'Seleccionar';

  @override
  String get saveTrip => 'Guardar viaje';

  @override
  String tripCreated(Object id) {
    return 'Viaje creado (# $id)';
  }

  @override
  String get registerTrip => 'Registrar Viaje';

  @override
  String get name => 'Nombre';

  @override
  String get travelDetails => 'Detalles del Viaje';

  @override
  String get loading => 'Cargando...';

  @override
  String get errorLoadingDetails => 'Error al cargar los detalles del viaje';

  @override
  String get tripStops => 'Paradas del Viaje';

  @override
  String get myStops => 'Mis Paradas';

  @override
  String get noStopsRegistered => 'No hay paradas registradas en este viaje.';

  @override
  String get stop => 'Parada';

  @override
  String get noParticipantsRegistered => 'No hay participantes registrados.';

  @override
  String get generatePdf => 'Generar PDF';

  @override
  String get experiences => 'Experiencias';

  @override
  String get registerExperience => 'Registrar Experiencia';

  @override
  String get comment => 'Comentario';

  @override
  String get photo => 'Foto';

  @override
  String get save => 'Guardar';

  @override
  String get noComment => 'Sin comentario';

  @override
  String createdAt(Object createdAt) {
    return 'Creado en: $createdAt';
  }

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get arrival => 'Llegada';

  @override
  String get departure => 'Salida';

  @override
  String get durationInDays => 'Duración (en días)';

  @override
  String get description => 'Descripción';

  @override
  String get add => 'Añadir';

  @override
  String get myTravels => 'Mis Viajes';

  @override
  String get noTravels => 'Ningún viaje';

  @override
  String get defineTripPeriod =>
      'Define el período de viaje para agregar paradas.';

  @override
  String get day => 'Día';

  @override
  String numberOfDays(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String get registerStop => 'Registrar parada';

  @override
  String get preferences => 'Preferencias';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Idioma';

  @override
  String get thankYouMessage => 'Gracias por utilizar';

  @override
  String get map => 'Mapa';

  @override
  String get transportMethod => 'Medio de Transporte';

  @override
  String get finalQuote =>
      'UN VIAJE NO SE MIDE EN MILLAS, SINO EN MOMENTOS.\nCADA PÁGINA DE ESTE FOLLETO GUARDA MÁS QUE PAISAJES: SON SONRISAS ESPONTÁNEAS, DESCUBRIMIENTOS INESPERADOS, CONVERSACIONES QUE QUEDARON EN EL ALMA Y SILENCIOS QUE HABLARON MÁS QUE PALABRAS.';

  @override
  String get loadingPdf => 'Generando PDF...';
}
