import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart' show BuildContext;
import 'package:travel_app/domain/entities/travel_with_details.dart';
import 'package:travel_app/domain/entities/travel_stop_experience.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/l10n/app_localizations.dart';

class GenerateTravelPdfUseCase {
  Future<void> call(
      BuildContext context,
      TravelWithDetails details, {
        Uint8List? mapImage,
      }) async {
    final l10n = AppLocalizations.of(context)!;
    final dateFmt = DateFormat(l10n.dateFormat);
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(margin: const pw.EdgeInsets.all(32), pageFormat: PdfPageFormat.a4),
        build: (pw.Context ctx) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                details.travel.name,
                style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                '${dateFmt.format(details.travel.initialDate)} - ${dateFmt.format(details.travel.endDate)}',
                style: pw.TextStyle(fontSize: 18),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                l10n.transportMethod,
                style: pw.TextStyle(fontSize: 18, fontStyle: pw.FontStyle.italic),
              ),
              pw.Text(
                details.travel.transportType.intlString(context),
                style: pw.TextStyle(fontSize: 24, fontStyle: pw.FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(margin: const pw.EdgeInsets.all(28)),
        build: (pw.Context ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(l10n.participants,
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            if (details.participants.isEmpty)
              pw.Text(l10n.noParticipantsRegistered)
            else
              pw.Wrap(
                spacing: 12,
                runSpacing: 12,
                children: details.participants.map((p) {
                  final buffer = _readFileSafely(p.photoPath);
                  return pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    width: 150,
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black, width: 0.5)),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (buffer != null)
                          pw.Container(
                            height: 100,
                            width: 100,
                            child: pw.Image(pw.MemoryImage(buffer), fit: pw.BoxFit.cover),
                          )
                        else
                          pw.Container(
                            height: 100,
                            width: 100,
                            alignment: pw.Alignment.center,
                            child: pw.Text(p.name.isNotEmpty ? p.name[0] : '?'),
                          ),
                        pw.SizedBox(height: 6),
                        pw.Text(p.name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(dateFmt.format(p.birthdate), style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );

    if (mapImage != null) {
      pdf.addPage(
        pw.Page(
          pageTheme: pw.PageTheme(margin: const pw.EdgeInsets.all(28)),
          build: (pw.Context ctx) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(l10n.map,
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Center(
                  child:
                  pw.Image(pw.MemoryImage(mapImage), height: 400, fit: pw.BoxFit.contain)),
            ],
          ),
        ),
      );
    }

    for (final stop in details.stops) {
      final experiencesTypes = stop.experiences.where((e) => e is! TravelStopExperience).toList();
      final experiencesDetails = stop.experiences.whereType<TravelStopExperience>().toList();

      pdf.addPage(
        pw.MultiPage(
          pageTheme: pw.PageTheme(margin: const pw.EdgeInsets.all(28)),
          build: (pw.Context ctx) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Text(stop.placeName,
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Text('${l10n.day} ${stop.dayIndex + 1}',
                        style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Text(
                    '${l10n.arrival}: ${dateFmt.format(stop.arrivalDate)}    •    ${l10n.departure}: ${dateFmt.format(stop.departureDate)}',
                    style: const pw.TextStyle(fontSize: 10)),
                if (stop.description.isNotEmpty) pw.SizedBox(height: 12),
                if (stop.description.isNotEmpty)
                  pw.Text('${l10n.description}: ${stop.description}',
                      style: const pw.TextStyle(fontSize: 10)),
                if (experiencesTypes.isNotEmpty) pw.SizedBox(height: 16),
                if (experiencesTypes.isNotEmpty)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(l10n.experiences,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                      pw.SizedBox(height: 6),
                      pw.Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: experiencesTypes.map((et) {
                          final label = _experienceLabel(et, l10n);
                          return pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(width: .4),
                                  borderRadius: pw.BorderRadius.circular(12)),
                              child: pw.Text(label,
                                  style: pw.TextStyle(fontSize: 11)));
                        }).toList(),
                      ),
                    ],
                  ),
                if (experiencesDetails.isNotEmpty) pw.SizedBox(height: 16),
                if (experiencesDetails.isNotEmpty)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: experiencesDetails.map((exp) {
                      final img = _readFileSafely(exp.photoPath);
                      return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (exp.comment != null && exp.comment!.isNotEmpty)
                            pw.Text('${l10n.comment}: ${exp.comment!}',
                                style: const pw.TextStyle(fontSize: 10)),
                          if (img != null) pw.SizedBox(height: 6),
                          if (img != null)
                            pw.Container(
                                height: 120,
                                child: pw.Image(pw.MemoryImage(img), fit: pw.BoxFit.cover)),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            l10n.createdAt(dateFmt.format(exp.createdAt)),
                            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey),
                          ),
                          pw.SizedBox(height: 8),
                        ],
                      );
                    }).toList(),
                  ),
              ],
            ),
          ],
        ),
      );
    }

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(margin: const pw.EdgeInsets.all(28)),
        build: (pw.Context ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              l10n.appTitle,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 32),
            pw.Text(
              l10n.finalQuote,
              style: pw.TextStyle(fontSize: 16, fontStyle: pw.FontStyle.italic),
              textAlign: pw.TextAlign.center,
            ),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/${details.travel.name.replaceAll(' ', '_')}.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFilex.open(file.path);
  }

  Uint8List? _readFileSafely(String? path) {
    if (path == null || path.isEmpty) return null;
    try {
      final f = File(path);
      if (!f.existsSync()) return null;
      return f.readAsBytesSync();
    } catch (_) {
      return null;
    }
  }

  String _experienceLabel(Object et, AppLocalizations l10n) {
    try {
      if (et is String) return et;
      if (et is Enum) return et.toString().split('.').last;
      return et.toString();
    } catch (_) {
      return et.toString();
    }
  }
}