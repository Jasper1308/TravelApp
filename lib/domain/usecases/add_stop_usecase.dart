import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/enums/experience_type.dart';
import 'package:travel_app/services/nominatim_service.dart';
import 'package:travel_app/utils/address_formatter.dart';

class AddStopUseCase {
  Future<TravelStop> call({
    required LatLng coordinates,
    String description = '',
    List<ExperienceType> experiences = const [],
    required int lengthStay,
    required int stopOrder,
    required int travelId,
    required DateTime arrivalDate,
    required DateTime departureDate,
  }) async {
    final reverse = await NominatimService.reverseGeocode(coordinates);
    final placeName = formatStopAddress(reverse.address!);

    return TravelStop(
      travelStopId: 0,
      stopOrder: stopOrder,
      placeName: placeName,
      coordinates: coordinates,
      description: description,
      dayIndex: 0,
      lengthStay: lengthStay,
      experiences: experiences,
      travelId: travelId,
      arrivalDate: arrivalDate,
      departureDate: departureDate,
    );
  }
}
