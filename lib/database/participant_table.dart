import 'package:travel_app/domain/entities/participant.dart';

class ParticipantTable {
  static const String createTable =
      '''
    CREATE TABLE $tableName(
      $participantId INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL,
      $birthdate TEXT NOT NULL,
      $photoPath TEXT NOT NULL
    );
  ''';

  static const String tableName = 'participant';
  static const String participantId = 'participantId';
  static const String name = 'name';
  static const String birthdate = 'birthdate';
  static const String photoPath = 'photoPath';

  static Map<String, dynamic> toMap(Participant participant){
    return{
      participantId: participant.participantId,
      name: participant.name,
      birthdate: participant.birthdate.toIso8601String(),
      photoPath: participant.photoPath
    };
  }
}
