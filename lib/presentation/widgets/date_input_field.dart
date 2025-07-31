import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInputField extends StatefulWidget {
  final String label;
  final ValueSetter<DateTime> onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  DateInputField({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  late final DateTime _firstDate;
  late final DateTime _lastDate;

  @override
  void initState() {
    super.initState();
    _firstDate = widget.firstDate ?? DateTime(1900);
    _lastDate = widget.lastDate ?? DateTime(2100);
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate;
      _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
      widget.onDateSelected(_selectedDate!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(labelText: widget.label),
      onTap: _selectDate,
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione uma data';
        }
        return null;
      }
      );
  }
}
