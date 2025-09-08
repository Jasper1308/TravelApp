import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStop {
  final int travelStopId;
  final int stopOrder;
  final String placeName;
  final LatLng coordinates;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final int lengthStay;
  final String description;
  final List<ExperienceType> experiences;
  final int dayIndex;
  final int travelId;

  TravelStop({
    required this.travelStopId,
    required this.stopOrder,
    required this.placeName,
    required this.coordinates,
    required this.arrivalDate,
    required this.departureDate,
    required this.lengthStay,
    required this.description,
    this.experiences = const [],
    required this.dayIndex,
    required this.travelId,
  });

  factory TravelStop.fromMap(Map<String, dynamic> map) {
    final experiencesRaw = map['experiences'];

    List<int> experienceIndexes = [];

    if (experiencesRaw is String) {
      try {
        final decoded = jsonDecode(experiencesRaw);
        if (decoded is List) {
          experienceIndexes = decoded
              .map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
              .toList();
        }
      } catch (_) {
        experienceIndexes = [];
      }
    } else if (experiencesRaw is List) {
      experienceIndexes = experiencesRaw
          .map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
          .toList();
    }

    return TravelStop(
      travelStopId: map['travelStopId'] is int
          ? map['travelStopId'] as int
          : int.tryParse(map['travelStopId']?.toString() ?? '') ?? 0,
      stopOrder: map['stopOrder'] as int? ?? 0,
      placeName: map['placeName'] as String? ?? '',
      coordinates: LatLng(
        (map['latitude'] as num?)?.toDouble() ?? 0.0,
        (map['longitude'] as num?)?.toDouble() ?? 0.0,
      ),
      arrivalDate:
          DateTime.tryParse(map['arrivalDate']?.toString() ?? '') ??
          DateTime(1970),
      departureDate:
          DateTime.tryParse(map['departureDate']?.toString() ?? '') ??
          DateTime(1970),
      lengthStay: map['lengthStay'] as int? ?? 0,
      description: (map['description'] ?? '') as String,
      experiences: experienceIndexes
          .map((i) => ExperienceType.values[i])
          .toList(),
      dayIndex: map['dayIndex'] as int? ?? 0,
      travelId: map['travelId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'travelStopId': travelStopId,
      'stopOrder': stopOrder,
      'placeName': placeName,
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
      'arrivalDate': arrivalDate.toIso8601String(),
      'departureDate': departureDate.toIso8601String(),
      'lengthStay': lengthStay,
      'description': description,
      'experiences': jsonEncode(experiences.map((e) => e.index).toList()),
      'dayIndex': dayIndex,
      'travelId': travelId,
    };
  }

  TravelStop copyWith({
    int? travelStopId,
    int? stopOrder,
    String? placeName,
    LatLng? coordinates,
    DateTime? arrivalDate,
    DateTime? departureDate,
    int? lengthStay,
    String? description,
    List<ExperienceType>? experiences,
    int? dayIndex,
    int? travelId,
  }) {
    return TravelStop(
      travelStopId: travelStopId ?? this.travelStopId,
      stopOrder: stopOrder ?? this.stopOrder,
      placeName: placeName ?? this.placeName,
      coordinates: coordinates ?? this.coordinates,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      departureDate: departureDate ?? this.departureDate,
      lengthStay: lengthStay ?? this.lengthStay,
      description: description ?? this.description,
      experiences: experiences ?? this.experiences,
      dayIndex: dayIndex ?? this.dayIndex,
      travelId: travelId ?? this.travelId,
    );
  }
}
