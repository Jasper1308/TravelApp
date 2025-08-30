import 'package:flutter/material.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/utils/dataFormatter.dart';

class TravelCard extends StatelessWidget {
  final Travel travel;
  final VoidCallback? onTap;

  const TravelCard({super.key, required this.travel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      travel.transportType.getTransportIcon,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      travel.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${formatTravelDate(context, travel.initialDate)} - ${formatTravelDate(context, travel.endDate)}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.group, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${travel.participants.length} participantes"),
                    const SizedBox(width: 16),
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${travel.stops.length} paradas"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
