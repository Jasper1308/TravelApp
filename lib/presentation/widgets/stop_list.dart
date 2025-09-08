import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/presentation/providers/travel_register_provider.dart';
import 'package:travel_app/presentation/widgets/register_button.dart';

class StopList extends StatelessWidget {
  const StopList({super.key});

  @override
  Widget build(BuildContext context) {
    final draft = context.watch<TravelRegisterProvider>();
    final stops = draft.stops;
    final totalDays = draft.totalDays;

    if (totalDays == 0) {
      return const Center(child: Text('Defina o período da viagem para adicionar paradas.'));
    }

    return Column(
      children: [
        Expanded(
          child: ReorderableListView.builder(
            itemCount: stops.length,
            onReorder: (oldIndex, newIndex) => context.read<TravelRegisterProvider>().reorderStops(oldIndex, newIndex),
            itemBuilder: (context, index) {
              final stop = stops[index];
              final dt = draft.dateForStop(stop);
              final locale = Localizations.localeOf(context);

              return Card(
                key: ValueKey(stop.travelStopId),
                child: ListTile(
                  title: Text(stop.placeName),
                  subtitle: Text(
                    'Dia \${stop.dayIndex + 1} • \${dt == null ? '' : DateFormat.yMMMd(locale.toString()).format(dt)}',
                  ),
                  trailing: DropdownButton<int>(
                    value: stop.dayIndex.clamp(0, totalDays - 1).toInt(),
                    items: List.generate(
                      totalDays,
                      (i) => DropdownMenuItem(value: i, child: Text('Dia \${i + 1}')),
                    ),
                    onChanged: (v) {
                      if (v != null) {
                        context.read<TravelRegisterProvider>().setStopDay(stop, v);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        RegisterButton(
          text: 'Cadastrar parada',
          onPressed: () => Navigator.pushNamed(
            context,
            '/travel-stop-register',
          ),
        ),
      ],
    );
  }
}
