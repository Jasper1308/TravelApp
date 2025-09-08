import 'package:travel_app/domain/entities/travel_stop.dart';

class ReorderStopsUseCase {
  void call(List<TravelStop> stops, int oldIndex, int newIndex, int totalDays) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final stop = stops.removeAt(oldIndex);
    stops.insert(newIndex, stop);

    for (int i = 0; i < stops.length; i++) {
      stops[i] = stops[i].copyWith(stopOrder: i);
    }

    int currentDay = 0;
    for (int i = 0; i < stops.length; i++) {
      final stop = stops[i];
      final newDayIndex = (currentDay + stop.lengthStay).clamp(0, totalDays - 1);
      stops[i] = stop.copyWith(dayIndex: newDayIndex);
      currentDay = newDayIndex;
    }
  }
}
