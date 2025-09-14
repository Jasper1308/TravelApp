import 'package:travel_app/domain/entities/travel_stop.dart';

class GetStopDateUseCase {
  DateTime? call(DateTime? initialDate, TravelStop stop, List<TravelStop> stops) {
    if (initialDate == null) return null;

    int daysPassed = 0;
    for (final s in stops) {
      if (s.placeName == stop.placeName && s.description == stop.description) {
        break;
      }
      daysPassed += s.lengthStay;
    }
    return initialDate.add(Duration(days: daysPassed));
  }
}