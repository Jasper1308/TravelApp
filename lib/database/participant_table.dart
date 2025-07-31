import 'package:travel_app/domain/entities/participant.dart';

class ParticipantTable {
  static const String createTable =
      '''
    CREATE TABLE $tableName(
      $participantId INTEGER PRIMARY KEY NOT NULL,
      $name TEXT NOT NULL,
      $age TEXT NOT NULL,
      $photoPath TEXT NOT NULL
    );
  ''';

  static const String tableName = 'participant';
  static const String participantId = 'participantId';
  static const String name = 'name';
  static const String age = 'age';
  static const String photoPath = 'photoPath';

  static Map<String, dynamic> toMap(Participant participant){
    return{
      participantId: participant.participantId,
      name: participant.name,
      age: participant.age,
      photoPath: participant.photoPath
    };
  }
}
