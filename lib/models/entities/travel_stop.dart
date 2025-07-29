import 'package:travel_app/models/enums/experience_type.dart';

class TravelStop {
  final int travelStopId;
  final int stopOrder;
  final String placeName;
  final String latitude;
  final String longitude;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final Duration lenghtStay;
  final List<ExperienceType> experiences;
  final String description;


  TravelStop({
    required this.travelStopId,
    required this.stopOrder,
    required this.placeName,
    required this.latitude,
    required this.longitude,
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
      latitude: map['latitude'],
      longitude: map['longitude'],
      arrivalDate: DateTime.parse(map['arrivalDate']),
      departureDate: DateTime.parse(map['departureDate']),
      lenghtStay: Duration(minutes: map['lenghtStay']),
      experiences: List<ExperienceType>.from(map['experiences']),
      description: map['description'],
    );
  }
}
