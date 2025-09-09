import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/presentation/providers/travel_details_provider.dart';

class TravelDetailsScreen extends StatelessWidget {
  final int travelId;

  const TravelDetailsScreen({super.key, required this.travelId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TravelDetailsProvider(
        Provider.of(context, listen: false),
      )..load(travelId),
      child: Consumer<TravelDetailsProvider>(
        builder: (ctx, provider, _) {
          if (provider.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (provider.details == null) {
            return const Scaffold(
              body: Center(child: Text('Erro ao carregar detalhes')),
            );
          }

          final details = provider.details!;
          return Scaffold(
            appBar: AppBar(title: Text(details.travel.name)),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${details.travel.initialDate} - ${details.travel.endDate}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Participantes:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ...details.participants.map((p) => ListTile(
                    title: Text(p.name),
                  )),
                  const SizedBox(height: 16),
                  Text(
                    'Paradas:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ...details.stops.map((s) => ListTile(
                    title: Text(s.description),
                    subtitle: Text(
                      '${s.arrivalDate} → ${s.departureDate}',
                    ),
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
