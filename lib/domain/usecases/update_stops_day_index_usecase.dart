import 'package:travel_app/domain/entities/travel_stop.dart';

/// UpdateStopsDayIndexUseCase
/// Returns a NEW list of TravelStop with dayIndex clamped to [0, totalDays-1].
/// This avoids mutating entities (supports immutable entities / copyWith pattern).
class UpdateStopsDayIndexUseCase {
  List<TravelStop> call(List<TravelStop> stops, int totalDays) {
    final maxIndex = totalDays > 0 ? totalDays - 1 : 0;
    return stops.map((stop) {
      final clamped = stop.dayIndex.clamp(0, maxIndex).toInt();
      return stop.copyWith(dayIndex: clamped);
    }).toList();
  }
}
