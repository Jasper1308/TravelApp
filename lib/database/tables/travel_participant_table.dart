import 'package:travel_app/database/tables/participant_table.dart';
import 'package:travel_app/database/tables/travel_table.dart';

class TravelParticipantTable {
  static const String tableName = 'travel_participants';
  static const String participantId = 'participantId';
  static const String travelId = 'travelId';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $participantId INTEGER NOT NULL,
      $travelId INTEGER NOT NULL,
      PRIMARY KEY ($participantId, $travelId),
      FOREIGN KEY ($participantId) REFERENCES ${ParticipantTable.tableName}(${ParticipantTable.participantId}),
      FOREIGN KEY ($travelId) REFERENCES ${TravelTable.tableName}(${TravelTable.travelId})
    );
  ''';
}
