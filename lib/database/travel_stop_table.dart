import 'package:travel_app/database/travel_table.dart';
import 'package:travel_app/models/entities/travel_stop.dart';

class TravelStopTable {
  static const String createTable =
      '''
    CREATE TABLE $tableName(
      $travelStopId INTEGER PRIMARY KEY NOT NULL,
      $cityName TEXT NOT NULL,
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
  static const String cityName = 'cityName';
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
      cityName: travelStop.cityName,
      latitude: travelStop.latitude,
      longitude: travelStop.longitude,
      arrivalDate: travelStop.arrivalDate,
      departureDate: travelStop.departureDate,
      lenghtStay: travelStop.lenghtStay.inMinutes,
      description: travelStop.description,
    };
  }
}