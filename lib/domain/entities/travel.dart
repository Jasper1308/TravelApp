import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/enums/transport_type.dart';

class Travel {
  final int travelId;
  final String name;
  final DateTime initialDate;
  final DateTime endDate;
  final TransportType transportType;
  final List<TravelStop> stops;
  final List<Participant> participants;

  Travel({
    required this.travelId,
    required this.name,
    required this.initialDate,
    required this.endDate,
    required this.transportType,
    List<TravelStop>? stops,
    List<Participant>? participants,
  }) : stops = stops ?? const [],
       participants = participants ?? const [];

  factory Travel.fromMap(Map<String, dynamic> map) {
    final idRaw = map['travelId'];
    final id = idRaw is int
        ? idRaw
        : int.tryParse(idRaw?.toString() ?? '') ?? 0;

    final initialRaw = map['initialDate'] as String?;
    final endRaw = map['endDate'] as String?;

    return Travel(
      travelId: id,
      name: map['name'] as String? ?? '',
      initialDate: DateTime.tryParse(initialRaw ?? '') ?? DateTime(1970),
      endDate: DateTime.tryParse(endRaw ?? '') ?? DateTime(1970),
      transportType: TransportType.values[map['transportType'] as int? ?? 0],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'travelId': travelId,
      'name': name,
      'initialDate': initialDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'transportType': transportType.index,
    };
  }

  Travel copyWith({
    int? travelId,
    String? name,
    DateTime? initialDate,
    DateTime? endDate,
    TransportType? transportType,
    List<TravelStop>? stops,
    List<Participant>? participants,
  }) {
    return Travel(
      travelId: travelId ?? this.travelId,
      name: name ?? this.name,
      initialDate: initialDate ?? this.initialDate,
      endDate: endDate ?? this.endDate,
      transportType: transportType ?? this.transportType,
      stops: stops ?? this.stops,
      participants: participants ?? this.participants,
    );
  }

  bool get hasValidDateRange => !initialDate.isAfter(endDate);
}
