import 'package:flutter/material.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/models/entities/travel.dart';

class MyTravelsScreen extends StatefulWidget {
  const MyTravelsScreen({super.key});

  @override
  State<MyTravelsScreen> createState() => _MyTravelsScreenState();
}

class _MyTravelsScreenState extends State<MyTravelsScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final List<Travel> travels = [];
    return Scaffold(
      appBar: AppBar(title: Text(locale.appTitle), centerTitle: true),
      body: travels.isEmpty
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
          : ListView.builder(itemBuilder: (context, index) => ListTile()),
    );
  }
}
