import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel.dart';

class TravelCard extends StatelessWidget {
  final Travel travel;
  const TravelCard({super.key, required this.travel});

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Card(
          child: Column(
            children: [
                ListTile(
                  leading: Icon(Icons.card_travel),
                  title: Text(travel.name),
                  subtitle: Text(travel.participants.join(',')),
                ),
            ],
          ),
        ),
    );
  }
}
