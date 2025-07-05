class TravelStop {
  final int travelStopId;
  final String cityName;
  final String latitude;
  final String longitude;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final Duration lenghtStay;
  final String description;
  final int travelId;

  TravelStop({
    required this.travelStopId,
    required this.cityName,
    required this.latitude,
    required this.longitude,
    required this.arrivalDate,
    required this.departureDate,
    required this.lenghtStay,
    required this.description,
    required this.travelId
  });
}
