import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/l10n/app_localizations.dart';

String formatTravelDate(BuildContext context, DateTime date) {
  final locale = AppLocalizations.of(context)!;
  final dateFormat = DateFormat(locale.dateFormat, Localizations.localeOf(context).toString());
  return dateFormat.format(date);
}