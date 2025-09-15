import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/domain/entities/travel_with_details.dart';
import 'package:travel_app/domain/usecases/generate_travel_pdf_usecase.dart';

class PdfGeneratorProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  final GenerateTravelPdfUseCase _generatePdf;

  PdfGeneratorProvider(this._generatePdf);

  Future<void> generate(
      BuildContext context,
      TravelWithDetails details,
      GoogleMapController mapController,
      ) async {
    _loading = true;
    notifyListeners();

    try {
      Uint8List? mapImage = await mapController.takeSnapshot();
      await _generatePdf.call(context, details, mapImage: mapImage);
    } catch (e) {
      print('Error generating PDF: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}