import 'package:travel_app/models/entities/travel_stop.dart';

class Travel{
  final String name;
  final String initialDate;
  final String endDate;
  final String transport;

  List<TravelStop> stops;

  Travel({
    required this.name,
    required this.initialDate,
    required this.endDate,
    required this.transport,
    required this.stops
  });
}