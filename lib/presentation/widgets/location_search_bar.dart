import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nominatim_flutter/model/response/nominatim_response.dart';
import 'package:travel_app/services/nominatim_service.dart';
import 'package:travel_app/utils/andress_formatter.dart';

class LocationSearchBar extends StatefulWidget {
  final Function(LatLng position) onPlaceSelected;

  const LocationSearchBar({super.key, required this.onPlaceSelected});

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<NominatimResponse> _results = [];
  bool _loading = false;
  Timer? _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        _search();
      } else {
        setState(() {
          _results.clear();
        });
      }
    });
  }

  void _search() async {
    setState(() {
      _loading = true;
    });
    final response = await NominatimService.searchPlaces(
      _searchController.text,
    );
    setState(() {
      _results = response;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Material(
              color: Colors.white.withValues(alpha: 0.8),
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Pesquisar',
                        border: InputBorder.none,
                      ),
                      onChanged: (_) => _onSearchChanged(),
                    ),
                  ),
                  if (_loading) const CircularProgressIndicator(),
                ],
              ),
            ),
            if (_results.isNotEmpty)
              Material(
                color: Colors.white.withValues(alpha: 0.8),
                elevation: 4,
                borderRadius: BorderRadius.circular(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        formatStopAndress(_results[index].address!),
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        final lat =
                            double.tryParse(_results[index].lat ?? '0') ?? 0;
                        final lon =
                            double.tryParse(_results[index].lon ?? '0') ?? 0;
                        widget.onPlaceSelected(LatLng(lat, lon));
                        setState(() {
                          _results.clear();
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
