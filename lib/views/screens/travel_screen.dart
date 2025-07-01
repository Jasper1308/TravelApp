import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/controllers/travel_provider.dart';
import 'package:travel_app/models/enums/transport_type.dart';

class TravelForm extends StatefulWidget {
  const TravelForm({super.key});

  @override
  State<TravelForm> createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  final _formKey = GlobalKey<FormState>();

  TransportType _transportType = TransportType.car;
  final TextEditingController _travelNameController = TextEditingController();
  final TextEditingController _initialDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _experiencesController = TextEditingController();
  final TextEditingController _stopsController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final travelState = Provider.of<TravelState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Viagem'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome da Viagem'),
                  controller: _travelNameController,
                ),
                const SizedBox(height: 32.0),
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
                const SizedBox(height: 32.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Data de Início',
                        ),
                        controller: _initialDateController,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Data de Término',
                        ),
                        controller: _endDateController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: travelState.stops.length,
                  itemBuilder: (context, index) {
                    final stop = travelState.stops[index];
                    return ListTile(
                      title: Text(stop.cityName),
                      subtitle: Text(stop.lenghtStay.inDays.toString()),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => travelState.removeStop
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  child: Text('Cadastrar parada'),
                    onPressed: () => Navigator.pushNamed(context, '/travel_stop')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
