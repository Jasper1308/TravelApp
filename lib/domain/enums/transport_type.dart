import 'package:flutter/material.dart';
import 'package:travel_app/l10n/app_localizations.dart';

enum TransportType { car, motorcycle, bus, plane, cruise, train }

extension TransportTypeExtension on TransportType {
  String intlString(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    switch (this) {
      case TransportType.car:
        return locale.car;
      case TransportType.motorcycle:
        return locale.motorcycle;
      case TransportType.bus:
        return locale.bus;
      case TransportType.plane:
        return locale.plane;
      case TransportType.cruise:
        return locale.cruise;
      case TransportType.train:
        return locale.train;
    }
  }

  IconData get getTransportIcon{
    switch (this) {
      case TransportType.car:
        return Icons.directions_car;
      case TransportType.motorcycle:
        return Icons.motorcycle;
      case TransportType.bus:
        return Icons.directions_bus;
      case TransportType.plane:
        return Icons.flight;
      case TransportType.cruise:
        return Icons.directions_boat;
      case TransportType.train:
        return Icons.train;
    }
  }
}
