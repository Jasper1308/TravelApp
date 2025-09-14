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
  String get train => 'Train';

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

  @override
  String get tapForDetails => 'Tap for details';

  @override
  String get tripName => 'Trip name';

  @override
  String get transport => 'Transport';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get participants => 'Participants';

  @override
  String get addParticipant => 'Add participant';

  @override
  String get registerParticipant => 'Register participant';

  @override
  String get selectParticipant => 'Select participant';

  @override
  String get birthdate => 'Birthdate';

  @override
  String get register => 'Register';

  @override
  String get requiredName => 'Name is required';

  @override
  String get fillAllFields => 'Fill all fields';

  @override
  String get select => 'Select';

  @override
  String get saveTrip => 'Save trip';

  @override
  String tripCreated(Object id) {
    return 'Trip created (# $id)';
  }

  @override
  String get registerTrip => 'Register Trip';

  @override
  String get name => 'Name';

  @override
  String get travelDetails => 'Travel Details';

  @override
  String get loading => 'Loading...';

  @override
  String get errorLoadingDetails => 'Error loading travel details';

  @override
  String get tripStops => 'Trip Stops';

  @override
  String get myStops => 'My Stops';

  @override
  String get noStopsRegistered => 'No stops registered for this trip.';

  @override
  String get stop => 'Stop';

  @override
  String get noParticipantsRegistered => 'No participants registered.';

  @override
  String get generatePdf => 'Generate PDF';

  @override
  String get experiences => 'Experiences';

  @override
  String get registerExperience => 'Register Experience';

  @override
  String get comment => 'Comment';

  @override
  String get photo => 'Photo';

  @override
  String get save => 'Save';

  @override
  String get noComment => 'No comment';

  @override
  String createdAt(Object createdAt) {
    return 'Created at: $createdAt';
  }

  @override
  String get loadingPdf => 'Generating PDF...';
}
