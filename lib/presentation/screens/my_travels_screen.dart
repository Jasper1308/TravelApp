import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/presentation/providers/travel_provider.dart';
import 'package:travel_app/presentation/widgets/travel_card.dart';

class MyTravelsScreen extends StatefulWidget {
  const MyTravelsScreen({super.key});

  @override
  State<MyTravelsScreen> createState() => _MyTravelsScreenState();
}

class _MyTravelsScreenState extends State<MyTravelsScreen> {

  @override
  void initState() {
    Provider.of<TravelState>(context).listTravel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final travelState = Provider.of<TravelState>(context);
    return Scaffold(
      appBar: AppBar(title: Text(locale.appTitle), centerTitle: true),
      body: travelState.travels.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.travel_explore, size: 56.0),
                    const SizedBox(height: 16),
                    Text(
                      locale.noTravelsMessage,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            )
          : Expanded(
              child: ListView.builder(
                itemCount: travelState.travels.length,
                itemBuilder: (context, index) =>
                    TravelCard(travel: travelState.travels[index]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/travel-register');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
