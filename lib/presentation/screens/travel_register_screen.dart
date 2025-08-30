import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/domain/entities/travel.dart';
import 'package:travel_app/presentation/providers/participant_provider.dart';
import 'package:travel_app/presentation/providers/travel_provider.dart';
import 'package:travel_app/domain/enums/transport_type.dart';
import 'package:travel_app/presentation/widgets/date_input_field.dart';
import 'package:travel_app/presentation/widgets/participant_list.dart';
import 'package:travel_app/presentation/widgets/register_button.dart';
import 'package:travel_app/presentation/widgets/stop_list.dart';

class TravelForm extends StatefulWidget {
  const TravelForm({super.key});

  @override
  State<TravelForm> createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  final _formKey = GlobalKey<FormState>();

  TransportType _transportType = TransportType.car;
  final TextEditingController _travelNameController = TextEditingController();
  DateTime? _initialDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    final travelState = Provider.of<TravelState>(context);
    final participantState = Provider.of<ParticipantState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Viagem'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome da Viagem'),
                    controller: _travelNameController,
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButton<TransportType>(
                    value: _transportType,
                    hint: Text('Tipo de Transporte'),
                    isExpanded: true,
                    items: TransportType.values.map((type) {
                      return DropdownMenuItem<TransportType>(
                        value: type,
                        child: Text(type.intlString(context)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _transportType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: DateInputField(
                          label: 'Data de Início',
                          onDateSelected: (date) {
                            setState(() {
                              _initialDate = date;
                            });
                          },
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: DateInputField(
                          label: 'Date de Término',
                          onDateSelected: (date) {
                            setState(() {
                              _endDate = date;
                            });
                          },
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32.0),

                  ParticipantList(),

                  const SizedBox(height: 32.0),

                  SizedBox(
                    height: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(),
                      ),
                      child: StopList(),
                    ),
                  ),

                  RegisterButton(
                    onPressed: () {
                      travelState.createTravel(
                        Travel(
                          travelId: 0,
                          name: _travelNameController.text,
                          initialDate: _initialDate!,
                          endDate: _endDate!,
                          transportType: _transportType,
                          stops: travelState.stops,
                          participants: participantState.participants,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    text: 'Cadastrar viagem',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
