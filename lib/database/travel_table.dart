import 'package:travel_app/domain/entities/travel.dart';

class TravelTable {
  static const String createTable =
      '''
    CREATE TABLE $tableName(
      $travelId INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL,
      $initialDate DATE NOT NULL,
      $endDate DATE NOT NULL,
      $transportType INTEGER NOT NULL,
    );
  ''';

  static const String tableName = 'travels';
  static const String travelId = 'travelId';
  static const String name = 'name';
  static const String initialDate = 'initialDate';
  static const String endDate = 'endDate';
  static const String transportType = 'transportType';

  static Map<String, dynamic> toMap(Travel travel){
    return {
      travelId: travel.travelId,
      name: travel.name,
      initialDate: travel.initialDate,
      endDate: travel.endDate,
      transportType: travel.transportType.index
    };
  }


}
