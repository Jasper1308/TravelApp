import 'package:travel_app/domain/entities/participant.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';

class TravelWithDetails {
  final Travel travel;
  final List<Participant> participants;
  final List<TravelStop> stops;

  TravelWithDetails({
    required this.travel,
    required this.participants,
    required this.stops,
  });
}
