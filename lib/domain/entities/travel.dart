import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/enums/transport_type.dart';

class Travel {
  final String travelId;
  final String name;
  final DateTime initialDate;
  final DateTime endDate;
  final TransportType transportType;
  List<TravelStop> stops;
  List<Participant> participants;

  Travel({
    required this.travelId,
    required this.name,
    required this.initialDate,
    required this.endDate,
    required this.transportType,
    required this.stops,
    required this.participants,
  });

  factory Travel.fromMap(Map<String, dynamic> map) {
    return Travel(
      travelId: map['travelId'],
      name: map['name'],
      initialDate: DateTime.parse(map['initialDate']),
      endDate: DateTime.parse(map['endDate']),
      transportType: TransportType.values[map['transportType']],
      stops: map['stops'] ?? [],
      participants: map['participants'] ?? [],
    );
  }
}
