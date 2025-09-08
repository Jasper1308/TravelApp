import 'package:travel_app/domain/entities/travel_stop.dart';

class GetStopDateUseCase {
  DateTime? call(DateTime? initialDate, TravelStop stop) {
    if (initialDate == null) {
      return null;
    }
    return initialDate.add(Duration(days: stop.dayIndex));
  }
}