import 'package:flutter/material.dart';
import 'package:travel_app/l10n/app_localizations.dart';

enum TransportType{
  car,
  motorcycle,
  bus,
  plane,
  cruise,
}

extension TransportTypeExtension on TransportType {
  String intlString(BuildContext context){
    final locale = AppLocalizations.of(context)!;
    switch(this){
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
    }
  }
}