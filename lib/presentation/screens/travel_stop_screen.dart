import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/controllers/travel_provider.dart';
import 'package:travel_app/domain/entities/travel_stop.dart';
import 'package:travel_app/domain/enums/experience_type.dart';

class TravelStopScreen extends StatefulWidget {
  const TravelStopScreen({super.key});

  @override
  State<TravelStopScreen> createState() => _TravelStopScreenState();
}

class _TravelStopScreenState extends State<TravelStopScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _cordinatesController = TextEditingController();
  DateTime? _arrivalDate;
  DateTime? _departureDate;
  List<ExperienceType> selectedExperiences = [];

  Future<void> _selectDate(isArrival) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );
    if(picked != null) {
      setState(() {
        if(isArrival){
          _arrivalDate = picked;
        } else {
          _departureDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final travelState = Provider.of<TravelState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Parada'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(

          // TODO: implement map for cordinates and cityname

          key: _formKey,
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: _placeController,
                  decoration: InputDecoration(labelText: 'Cidade'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _cordinatesController,
                  decoration: InputDecoration(labelText: 'Coordenadas'),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(true),
                        child: Text(
                          'Chegada'
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(false),
                        child: Text('Saida'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  child: Text('Cadastrar parada'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Duration stayDuration = _departureDate!.difference(_arrivalDate!);
                      final stop = TravelStop(
                          travelStopId: travelState.travels.length,
                          stopOrder: travelState.stops.length,
                          placeName: placeName,
                          latitude: latitude,
                          longitude: longitude,
                          arrivalDate: _arrivalDate,
                          departureDate: _departureDate,
                          lenghtStay: stayDuration,
                          experiences: experiences,
                          description: description
                      );
                      travelState.addStop(stop);


                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
