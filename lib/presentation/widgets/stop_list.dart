import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/presentation/providers/travel_provider.dart';
import 'package:travel_app/presentation/widgets/register_button.dart';

class StopList extends StatefulWidget {
  const StopList({super.key});

  @override
  State<StopList> createState() => _StopListState();
}

class _StopListState extends State<StopList> {

  @override
  Widget build(BuildContext context) {
    final travelState = Provider.of<TravelState>(context);
    final List<TravelStop> stops = travelState.stops;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              children: <Widget>[
                for (final stop in stops)
                  Card(
                    key: ValueKey(stop.stopOrder),
                    child: SizedBox(height: 80, child: Center(child: Text(stop.placeName))),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                travelState.updateStopOrder(oldIndex, newIndex);
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
      ),
    );
  }
}