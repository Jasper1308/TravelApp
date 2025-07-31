import 'package:flutter/material.dart';
import 'package:travel_app/l10n/app_localizations.dart';

enum ExperienceType { culture, culinary, historic, localEstablishments, nature }

extension ExperienceTypeExtension on ExperienceType {
  String intlString(BuildContext context){
    final locale = AppLocalizations.of(context)!;
    switch (this) {
      case ExperienceType.culture:
        return locale.culture;
      case ExperienceType.culinary:
        return locale.culinary;
      case ExperienceType.historic:
        return locale.historic;
      case ExperienceType.localEstablishments:
        return locale.localEstablishments;
      case ExperienceType.nature:
        return locale.nature;
    }
  }
}
