import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/travel_register_provider.dart';
import 'package:travel_app/presentation/providers/travel_stop_provider.dart';
import 'package:travel_app/presentation/screens/travel_stop_register_screen.dart';
import 'package:travel_app/presentation/widgets/register_button.dart';
import 'package:reorderables/reorderables.dart';

class StopList extends StatelessWidget {
  const StopList({super.key});

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<TravelRegisterProvider>();
    final stopProvider = context.watch<TravelStopProvider>();
    final stops = stopProvider.stops;
    final totalDays = registerProvider.totalDays;
    final l10n = AppLocalizations.of(context)!;

    if (totalDays == 0) {
      return Center(
        child: Text(l10n.defineTripPeriod),
      );
    }

    return Column(
      children: [
        ReorderableColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: stops.asMap().entries.map((entry) {
            final index = entry.key;
            final stop = entry.value;
            return Dismissible(
              key: ValueKey(stop.placeName + stop.description),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                context.read<TravelStopProvider>().removeStop(stop);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                key: ValueKey(stop.travelStopId),
                child: ListTile(
                  title: Text(stop.placeName),
                  subtitle: Text(
                    '${l10n.day} ${stop.dayIndex + 1} • ${registerProvider.dateForStop(stop, stops) != null ? DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(registerProvider.dateForStop(stop, stops)!) : ''}',
                  ),
                  trailing: DropdownButton<int>(
                    value: (stop.lengthStay).clamp(1, registerProvider.totalDays),
                    items: List.generate(
                      registerProvider.totalDays,
                          (i) => DropdownMenuItem(
                        value: i + 1,
                        child: Text(l10n.numberOfDays(i + 1)),
                      ),
                    ),
                    onChanged: (v) {
                      if (v != null) {
                        context.read<TravelStopProvider>().setStopLength(
                          index,
                          v,
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          }).toList(),
          onReorder: (oldIndex, newIndex) {
            stopProvider.reorder(oldIndex, newIndex, totalDays);
          },
        ),
        const SizedBox(height: 12),
        RegisterButton(
          text: l10n.registerStop,
          onPressed: () {
            final stopProvider = context.read<TravelStopProvider>();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: stopProvider,
                  child: const TravelStopRegisterScreen(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}