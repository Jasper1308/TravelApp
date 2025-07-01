import 'package:travel_app/models/entities/participant.dart';
import 'package:travel_app/models/entities/travel_stop.dart';
import 'package:travel_app/models/enums/experience_type.dart';
import 'package:travel_app/models/enums/transport_type.dart';

class Travel {
  final String name;
  final DateTime initialDate;
  final DateTime endDate;
  final TransportType transportType;
  final List<ExperienceType> experiences;
  final List<TravelStop> stops;
  final List<Participant> participants;

  Travel({
    required this.name,
    required this.initialDate,
    required this.endDate,
    required this.transportType,
    required this.experiences,
    required this.stops,
    required this.participants,
  });
}
