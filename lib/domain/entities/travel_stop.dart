import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStop {
  int travelStopId;
  final int stopOrder;
  final String placeName;
  final LatLng cordinates;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final Duration lenghtStay;
  final List<ExperienceType> experiences;
  final String description;


  TravelStop({
    required this.travelStopId,
    required this.stopOrder,
    required this.placeName,
    required this.cordinates,
    required this.arrivalDate,
    required this.departureDate,
    required this.lenghtStay,
    required this.experiences,
    required this.description,
  });
  factory TravelStop.fromMap(Map<String, dynamic> map) {
    return TravelStop(
      travelStopId: map['travelStopId'],
      stopOrder: map['stopOrder'],
      placeName: map['cityName'],
      cordinates: LatLng(map['latitude'], map['longitude']),
      arrivalDate: DateTime.parse(map['arrivalDate']),
      departureDate: DateTime.parse(map['departureDate']),
      lenghtStay: Duration(minutes: map['lenghtStay']),
      experiences: List<ExperienceType>.from(map['experiences']),
      description: map['description'],
    );
  }
}
