import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:travel_app/domain/entities/travel_with_details.dart';

class PdfGeneratorProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  Future<void> generateTravelPdf(TravelWithDetails details) async {
    _loading = true;
    notifyListeners();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          return pw.Column(
            children: [
              pw.Text(
                details.travel.name,
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Período: ${details.travel.initialDate.toLocal().toString().split(' ')[0]} - ${details.travel.endDate.toLocal().toString().split(' ')[0]}',
                style: const pw.TextStyle(fontSize: 16),
              ),
            ],
          );
        },
        build: (pw.Context context) {
          return [
            pw.SizedBox(height: 24),
            pw.Text('Participantes:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            if (details.participants.isEmpty)
              pw.Text('Nenhum participante registrado.')
            else
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: details.participants.map((p) => pw.Text('- ${p.name}')).toList(),
              ),
            pw.SizedBox(height: 24),
            pw.Text('Paradas:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            if (details.stops.isEmpty)
              pw.Text('Nenhuma parada registrada.')
            else
              ...details.stops.map((stop) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 12),
                    pw.Text(
                      stop.placeName,
                      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text('Chegada: ${stop.arrivalDate.toLocal().toString().split(' ')[0]}'),
                    pw.Text('Partida: ${stop.departureDate.toLocal().toString().split(' ')[0]}'),
                    if (stop.description.isNotEmpty)
                      pw.Text('Descrição: ${stop.description}'),
                    pw.SizedBox(height: 8),
                    // Adicionar experiências
                    pw.Text('Experiências:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 4),
                    // Nota: A sua entidade TravelStop não tem a lista de experiências.
                    // Você precisará carregá-las no TravelWithDetails para que funcione aqui.
                    // Exemplo: details.stops.first.experiences.map((exp) => pw.Text(exp.comment!)).toList()
                  ],
                );
              }).toList(),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/${details.travel.name.replaceAll(' ', '_')}_viagem.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFilex.open(file.path);

    _loading = false;
    notifyListeners();
  }
}