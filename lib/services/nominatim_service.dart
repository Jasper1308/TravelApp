import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/model/response/nominatim_response.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

class NominatimService {
  static Future<List<NominatimResponse>> searchPlaces(String query) async {
    if (query.isEmpty) return [];

    final searchRequest = SearchRequest(
      query: query,
      limit: 3,
      addressDetails: true,
      nameDetails: true,
    );

    final searchResult = await NominatimFlutter.instance.search(
      searchRequest: searchRequest,
    );

    return searchResult;

    // return searchResult.map((r) {
    //   return LatLng(double.parse(r.lat!), double.parse(r.lon!));
    // }).toList();
  }

  static Future<NominatimResponse> reverseGeocode(LatLng position) async {
    final reverseRequest = ReverseRequest(
      lat: position.latitude,
      lon: position.longitude,
      addressDetails: true,
      nameDetails: true,
    );
    final reverseResult = await NominatimFlutter.instance.reverse(
      reverseRequest: reverseRequest,
    );
    return reverseResult;
  }
}
