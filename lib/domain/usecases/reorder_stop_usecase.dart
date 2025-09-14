import 'package:travel_app/domain/entities/travel_stop.dart';

class ReorderStopsUseCase {
  void call(List<TravelStop> stops, int oldIndex, int newIndex, int totalDays) {
    if (stops.isEmpty) return;
    if (oldIndex < newIndex) newIndex -= 1;
    final item = stops.removeAt(oldIndex);
    stops.insert(newIndex, item);

    for (int i = 0; i < stops.length; i++) {
      stops[i] = stops[i].copyWith(stopOrder: i);
    }

    int currentDay = 0;
    for (int i = 0; i < stops.length; i++) {
      final s = stops[i];
      final dayIndex = totalDays > 0 ? currentDay.clamp(0, totalDays - 1) : 0;
      stops[i] = s.copyWith(dayIndex: dayIndex);
      currentDay += s.lengthStay;
      if (totalDays > 0 && currentDay >= totalDays) currentDay = totalDays - 1;
    }
  }
}
