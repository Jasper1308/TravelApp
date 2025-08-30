import 'package:travel_app/database/travel_table.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';

class TravelStopTable {
  static const String createTable =
      '''
    CREATE TABLE $tableName(
      $travelStopId INTEGER PRIMARY KEY AUTOINCREMENT,
      $stopOrder INTEGER NOT NULL,
      $placeName TEXT NOT NULL,
      $latitude REAL NOT NULL,
      $longitude REAL NOT NULL,
      $arrivalDate DATE NOT NULL,
      $departureDate DATE NOT NULL,
      $lenghtStay INTEGER NOT NULL,
      $description TEXT NOT NULL,
      $travelId INTEGER NOT NULL,
      FOREIGN KEY ($travelId) REFERENCES ${TravelTable.tableName}(${TravelTable.travelId})
    );
  ''';

  static const String tableName = 'travelStop';
  static const String travelStopId = 'travelStopId';
  static const String stopOrder = 'stopOrder';
  static const String placeName = 'placeName';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String arrivalDate = 'arrivalDate';
  static const String departureDate = 'departureDate';
  static const String lenghtStay = 'lenghtStay';
  static const String description = 'description';
  static const String travelId = 'travelId';

  static Map<String, dynamic> toMap(TravelStop travelStop){
    return{
      travelStopId: travelStop.travelStopId,
      stopOrder: travelStop.stopOrder,
      placeName: travelStop.placeName,
      latitude: travelStop.cordinates.latitude,
      longitude: travelStop.cordinates.longitude,
      arrivalDate: travelStop.arrivalDate.toIso8601String(),
      departureDate: travelStop.departureDate.toIso8601String(),
      lenghtStay: travelStop.lenghtStay.inMinutes,
      description: travelStop.description,
    };
  }
}