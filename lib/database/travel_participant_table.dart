import 'package:travel_app/database/participant_table.dart';
import 'package:travel_app/database/travel_table.dart';
import 'package:travel_app/domain/entities/participant.dart';

class TravelParticipantTable {
  static const String createTable =
      '''
    CREATE TABLE $tableName(
      $participantId INT NOT NULL,
      $travelId INT NOT NULL,
      PRIMARY KEY ($participantId, $travelId),
      FOREIGN KEY (participantId) REFERENCES ${ParticipantTable.tableName}(${ParticipantTable.participantId}),
      FOREIGN KEY (travelId) REFERENCES ${TravelTable.tableName}(${TravelTable.travelId})
    )
  ''';

  static const String tableName = 'travelParticipant';
  static const String participantId = 'participantId';
  static const String travelId = 'travelId';



}
