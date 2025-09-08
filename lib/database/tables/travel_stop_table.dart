import 'package:travel_app/database/tables/travel_table.dart';

class TravelStopTable {
  static const String tableName = 'travel_stops';
  static const String travelStopId = 'travelStopId';
  static const String stopOrder = 'stopOrder';
  static const String placeName = 'placeName';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String arrivalDate = 'arrivalDate';
  static const String departureDate = 'departureDate';
  static const String lengthStay = 'lengthStay';
  static const String description = 'description';
  static const String experiences = 'experiences';
  static const String dayIndex = 'dayIndex';
  static const String travelId = 'travelId';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $travelStopId INTEGER PRIMARY KEY AUTOINCREMENT,
      $stopOrder INTEGER NOT NULL,
      $placeName TEXT NOT NULL,
      $latitude REAL NOT NULL,
      $longitude REAL NOT NULL,
      $arrivalDate TEXT NOT NULL,
      $departureDate TEXT NOT NULL,
      $lengthStay INTEGER NOT NULL,
      $description TEXT NOT NULL,
      $experiences TEXT,
      $dayIndex INTEGER NOT NULL,
      $travelId INTEGER NOT NULL,
      FOREIGN KEY ($travelId) REFERENCES ${TravelTable.tableName}(${TravelTable.travelId}) ON DELETE CASCADE
    );
  ''';
}
