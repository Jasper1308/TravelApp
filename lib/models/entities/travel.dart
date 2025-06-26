import 'package:travel_app/models/entities/travel_stop.dart';

class Travel{
  String name;
  String initialDate;
  String endDate;
  String transport;

  List<TravelStop> stops;

  Travel(
      this.name,
      this.initialDate,
      this.endDate,
      this.transport,
      this.stops
      );
}