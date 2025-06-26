import 'package:flutter/material.dart';
import 'package:travel_app/models/entities/travel.dart';

import '../l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final List<Travel> travels = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.appTitle),
        centerTitle: true,
      ),
      body: travels.isEmpty ?
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.travel_explore,
                    size: 56.0
                  ),
                  const SizedBox(height: 16),
                  Text(
                      locale.noTravelsMessage,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                  ),
                ],
              ),
            ),
          ) :
          ListView.builder(
            itemBuilder: (context, index) => ListTile()
          ),
      floatingActionButton:
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("Pressed");
          }
        ),
    );
  }
}
